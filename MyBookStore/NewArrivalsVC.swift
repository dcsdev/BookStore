//
//  NewArrivalsVC.swift
//  MyBookStore
//
//  Created by Douglas Spencer on 11/4/20.
//

import UIKit

class NewArrivalsVC: UIViewController{

    @IBOutlet weak var newArrivalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        newArrivalTableView.dataSource  = self
        newArrivalTableView.delegate    = self
        
        newArrivalTableView.backgroundColor = .clear
        
    }
}

extension NewArrivalsVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NewArrivalbookData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookCell
        
                cell?.setupUI(for: NewArrivalbookData[indexPath.row])
        
                return cell!
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220.0
    }
}
