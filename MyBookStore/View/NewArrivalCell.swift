//
//  BookCell.swift
//  MyBookStore
//
//  Created by Douglas Spencer on 10/18/20.
//

import UIKit
import SDWebImage

class NewArrivalCell: UITableViewCell {
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookPrice: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookCoverImage: UIImageView!
    
     func setupUI(for book: Book) {
        
        bookTitle.text = book.Title
        bookPrice.text = book.Price
        bookAuthor.text = book.Author
        
        bookCoverImage.sd_setImage(with: URL(string: book.ImageUrl)) { (image, error, catch, url) in
            debugPrint("SD Web Image Has Finished Loading Book Image")
        }
    }
}
