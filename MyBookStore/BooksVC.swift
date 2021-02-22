//
//  ViewController.swift
//  MyBookStore
//
//  Created by Douglas Spencer on 10/17/20.
//

import UIKit
import NotificationCenter

class BooksVC: UIViewController {
    
    @IBOutlet weak var booksTableView: UITableView!
    
    var tabBarItemSales         : UITabBarItem!
    var tabBarItemSettings      : UITabBarItem!
    var tabBarItemNewArrival    : UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        booksTableView.dataSource = self
        booksTableView.delegate = self
        
        tabBarItemSales = (tabBarController?.tabBar.items?[0])!
        tabBarItemNewArrival = (tabBarController?.tabBar.items?[1])!
        tabBarItemSettings = (tabBarController?.tabBar.items?[2])!
        
        //Add Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsNotification), name: .didRecieveSetting, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewArrivalNotification), name: .didRecieveNewArrival, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CurentSalesNotification), name: .didRecieveSale, object: nil)
    }
    
    @objc func SettingsNotification()
    {
        debugPrint("Recieved Settings Notification...")
        tabBarItemSettings.badgeColor = UIColor.red
        tabBarItemSettings.badgeValue = "1"
        
    }
    
    @objc func NewArrivalNotification()
    {
        debugPrint("New Arrival Notification...")
        tabBarItemNewArrival.badgeColor = UIColor.red
        tabBarItemNewArrival.badgeValue = "2"
    }
    
    @objc func CurentSalesNotification()
    {
        debugPrint("Current Sales Notification...")
        tabBarItemSales.badgeColor = UIColor.red
        tabBarItemSales.badgeValue = "3"
    }
}

extension UIViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookCell
        cell?.setupUI(for: BookData[indexPath.row])
        
        return cell!
    
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220.0
    }
}

