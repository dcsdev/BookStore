//
//  SettingsVC.swift
//  MyBookStore
//
//  Created by Douglas Spencer on 11/4/20.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    
    struct Settings {
       let section_name : String
       var section_items : [[String:Any]]
    }
    
    var userSettings: [Settings] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        userSettings.append(Settings(section_name: "Personal Information", section_items: [["Item" : "Name: Douglas Spencer"], ["Item" : "Address: 123 My Street"], ["Item" : "City: My Town"], ["Item" : "State: My State"], ["Item" : "Zip: My Zip"]]))
        userSettings.append(Settings(section_name: "Billing", section_items: [["Item" : "Credit Card: XXXX-XXXX-XXXX-1234"]]))
        userSettings.append(Settings(section_name: "Security", section_items: [["Item" : "Password: ********"]]))
        userSettings.append(Settings(section_name: "Miscelleanous", section_items: [["Item" : "Birthday November 29th"]]))
    }
    
    fileprivate func applyGradient() {
        let red =  UIColor.red.cgColor
        let blue = UIColor.blue.cgColor

        let gradLayer = CAGradientLayer()
        gradLayer.colors = [red, blue]
        gradLayer.locations = [0.0, 1.0]
        gradLayer.frame = self.view.bounds

        self.settingsTableView.layer.insertSublayer(gradLayer, at:0)
        
        settingsTableView.backgroundColor = .clear
    
    }
}

extension SettingsVC {
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return userSettings.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = self.userSettings[section].section_items
           return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        let items = self.userSettings[indexPath.section].section_items
            let item = items[indexPath.row]
        cell.textLabel?.text = item["Item"] as? String
            return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.userSettings[section].section_name
    }
    
}
