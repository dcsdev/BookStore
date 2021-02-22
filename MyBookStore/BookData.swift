//
//  BookData.swift
//  MyBookStore
//
//  Created by Douglas Spencer on 10/18/20.
//

import Foundation


let BookData : [Book] = [
    
    Book(Title: "Charlotte's Web", Price: "$8.99", ImageUrl: "https://prodimage.images-bn.com/pimages/9780064400558_p0_v3_s550x406.jpg", Author: "E. B White")
    ,Book(Title: "Of Mice and Men", Price: "$10.99", ImageUrl: "https://prodimage.images-bn.com/pimages/9780140177398_p0_v2_s550x406.jpg", Author: "John Steinbeck")
    ,Book(Title: "The Great Gatsby", Price: "$13.99", ImageUrl: "https://prodimage.images-bn.com/pimages/9780743273565_p0_v8_s550x406.jpg", Author: "F. Scott Fitzgerald")
    ,Book(Title: "Anne of Green Gables", Price: "$10.00", ImageUrl: "https://prodimage.images-bn.com/pimages/9781435162099_p0_v2_s550x406.jpg", Author: "L.M. Montgomery")    
]

let NewArrivalbookData : [Book] = [
    Book(Title: "Dear Universe, I Get It Now", Price: "$9.99", ImageUrl: "https://m.media-amazon.com/images/I/51rPHXxHsZL.jpg", Author: "A.Y. Berthiaume")
]

let SettingsData: [String] = [
    "Personal Information",
    "Billing",
    "Security",
    "Miscellaneous"
]
