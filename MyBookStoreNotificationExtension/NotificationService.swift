//
//  NotificationService.swift
//  MyBookStoreNotificationExtension
//
//  Created by Douglas Spencer on 10/24/20.
//

import UserNotifications
import UIKit

extension UNNotificationRequest {
    var attachment: UNNotificationAttachment? {
        guard let attachmentURL = content.userInfo["image-url"] as? String,
              let imageData = UIImage(named: "3DBook")?.jpegData(compressionQuality: 1.0) else {
            return nil
        }
        
        return try? UNNotificationAttachment(data: imageData, options: nil)
    }
}

extension UNNotificationAttachment {

    convenience init(data: Data, options: [NSObject: AnyObject]?) throws {
        let fileManager = FileManager.default
        let temporaryFolderName = ProcessInfo.processInfo.globallyUniqueString
        let temporaryFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(temporaryFolderName, isDirectory: true)

        try fileManager.createDirectory(at: temporaryFolderURL, withIntermediateDirectories: true, attributes: nil)
        let imageFileIdentifier = UUID().uuidString + ".gif"
        let fileURL = temporaryFolderURL.appendingPathComponent(imageFileIdentifier)
        try data.write(to: fileURL)
        try self.init(identifier: imageFileIdentifier, url: fileURL, options: options)
    }
}

final class NotificationService: UNNotificationServiceExtension {

    private var contentHandler: ((UNNotificationContent) -> Void)?
    private var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            guard let imageURLString =
                    bestAttemptContent.userInfo["podcast-image"] as? String else {
                contentHandler(bestAttemptContent)
              return
            }
            
            downloadPushNotificationImage(for: imageURLString) { [self] (image) in
                //If we downloaded the file, save it to disk
                guard let fileURL = self.saveImageAttachment(image: image!, forIdentifier: "attachment.gif") else {
                    contentHandler(bestAttemptContent)
                    return
                }
                
                let imgAtt = try? UNNotificationAttachment(identifier: "image", url: fileURL, options: nil)
                
                if let imgAtt = imgAtt {
                    bestAttemptContent.attachments = [imgAtt]
                }
                
                contentHandler(bestAttemptContent)
            }
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
    
    private func downloadPushNotificationImage(for url: String, completion: @escaping (UIImage?) -> Void) {
        //Make sure we have a valid URL for the passed in string
        //If a URL cannot be made, we simply call the completion handler with nil
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        //Since we got this far, we will attempt to download image from the URL
        //There are a lot of ways to download an image with swift, but we will use a simple method here
        if let data = try? Data(contentsOf: url) {
                //We have gotten the data, so we can build an image with it here
            guard let image = UIImage(data: data) else {
                completion(nil)
                return
            }
                completion(image)
                
            }
    }
    
    

//
//
    private func saveImageAttachment(
      image: UIImage,
      forIdentifier identifier: String
    ) -> URL? {
      // 1
      let tempDirectory = URL(fileURLWithPath: NSTemporaryDirectory())
      // 2
      let directoryPath = tempDirectory.appendingPathComponent(
        ProcessInfo.processInfo.globallyUniqueString,
        isDirectory: true)

      do {
        // 3
        try FileManager.default.createDirectory(
          at: directoryPath,
          withIntermediateDirectories: true,
          attributes: nil)

        // 4
        let fileURL = directoryPath.appendingPathComponent(identifier)

        // 5
        guard let imageData = image.pngData() else {
          return nil
        }

        // 6
        try imageData.write(to: fileURL)
          return fileURL
        } catch {
          return nil
      }
    }
}
