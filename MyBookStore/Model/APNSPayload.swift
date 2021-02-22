//
//  APNSPayload.swift
//  MyBookStore
//
//  Created by Douglas Spencer on 10/24/20.
//

import Foundation

struct APNSPayload  {
    var alert               : String?
    var sound               : String?
    var body                : String?
    var link                : String?
    var content_available   : String?
    var category            : String?
    
    init()
    {
        self.body = ""
        self.category = ""
        self.sound =  ""
        self.link =  ""
        self.content_available =  ""
        self.alert = ""
    }
    
    init(apnsDict: [AnyHashable : Any])
    {
        self.init()
        
        if let aps = apnsDict["aps"] as? [String: Any] {
            
            self.body               = aps["body"] as? String ?? ""
            self.category           = aps["category"] as? String ?? ""
            self.sound              = aps["sound"] as? String ?? ""
            self.link               = aps["link"] as? String ?? ""
            self.content_available  = aps["link"] as? String ?? ""
            self.alert              = aps["alert"] as? String ?? ""
        }
    }
}



