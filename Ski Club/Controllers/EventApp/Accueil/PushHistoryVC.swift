//
//  LastPushVC.swift
//  Adhenarcos
//
//  Created by Arthur Péligry on 07/12/2017.
//  Copyright © 2017 Foxmob. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftyJSON
import SwiftDate
import NVActivityIndicatorView
import Spring
import Kingfisher
import Haptica
import CFAlertViewController
import ChameleonFramework

class PushHistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref: DatabaseReference?
    
    var nextDiffInMinutes = [Int]()
    
    @IBOutlet weak var tableView: UITableView!
    
    var localNotifs = [[String:String]]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        loadNotifs()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Database initialisation
        ref = Database.database().reference()
        
        tableView.rowHeight = 75
        
        calculateTimestamp()
        
    }
    
    func loadNotifs() {
        
        ref?.child("eventData").child("push").observe(.value) {
            (snapshot: DataSnapshot) in
            
            self.localNotifs.removeAll()

            if ( snapshot.value is NSNull ) {

            } else {

                if let value = snapshot.value {
                    
                    let j = JSON(value)
                    
                    for (key,subJson):(String, JSON) in j {
                        let titre = subJson["content"].string!
                        let heure = subJson["date"].string!
                        
                        self.localNotifs.insert(["titre": titre, "date": heure], at: 0)
                    }
                    
                }
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                    self.calculateTimestamp()
                    Animations.animateCells(tableView: self.tableView)

                })

            }
        }

    }
    

    
   
    func calculateTimestamp() {
       
        self.nextDiffInMinutes.removeAll()
        
        for element in localNotifs {
            let paris = Region(calendar: Calendars.gregorian, zone: Zones.europeParis, locale: Locales.french)
            let date = try! DateInRegion(element["date"]!, format: "yyyy-MM-dd HH:mm:ss", region: paris)
            let dateInParis = DateInRegion(Date(), region: paris)
            let resultInMinutes = date!.getInterval(toDate: dateInParis, component: .minute)
            
            self.nextDiffInMinutes.append(Int(resultInMinutes))
        
        }
        
        
    }
    
    // TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localNotifs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PushCell") as! PushCell
        cell.selectionStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none // OK
        
        cell.push.text = localNotifs[indexPath.row]["titre"]
        
        if nextDiffInMinutes[indexPath.row] < 60 {
            cell.time.text = "Il y a \(nextDiffInMinutes[indexPath.row]) minutes"
        } else if  nextDiffInMinutes[indexPath.row] > 60 {
            cell.time.text = "Il y a plus d'une heure"
        } else {
            cell.time.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var titre = ""
        
        if nextDiffInMinutes[indexPath.row] < 60 {
            titre = "Notification il y a \(nextDiffInMinutes[indexPath.row]) mn"
        } else {
            titre = "Notification il y a plus d'une heure"
        }
        
        // Create Alet View Controller
        let alertController = CFAlertViewController(title: titre,
                                                    message: "\(localNotifs[indexPath.row]["titre"]!) \r\n\r\n\r\n",
            textAlignment: .left,
            preferredStyle: .actionSheet,
            didDismissAlertHandler: nil)
        
        // Create Upgrade Action
        let defaultAction = CFAlertAction(title: "Ça roule !",
                                          style: .Default,
                                          alignment: .right,
                                          backgroundColor: UIColor(hexString:"C00011"),
                                          textColor: UIColor(hexString:"ffffff"),
                                          handler: { (action) in
                                            print("Button with title '" + action.title! + "' tapped")
        })
        
        // Add Action Button Into Alert
        alertController.addAction(defaultAction)
        
        // Present Alert View Controller
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

