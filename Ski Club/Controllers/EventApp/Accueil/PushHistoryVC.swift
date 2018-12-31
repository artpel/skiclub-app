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
    
    // Variable de référence à la Database Firebase
    var ref: DatabaseReference?
    
    var nextDiffInMinutes = [Double]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: NVActivityIndicatorView!
    
    var localNotifs = JSON()
    
    var oTitle = ""
    var oDescription = ""
    
    
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

            if ( snapshot.value is NSNull ) {

            } else {

                if let value = snapshot.value {
                    
                    self.localNotifs = JSON(value)
                    
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
        //LocalData.Push.timestamps = LocalData.Push.timestamps.reversed()
        //LocalData.Push.pushList = LocalData.Push.pushList.reversed()
        
        var i = 0
        
        for (key,subJson):(String, JSON) in localNotifs {
            let paris = Region(calendar: Calendars.gregorian, zone: Zones.europeParis, locale: Locales.french)
            let date = try! DateInRegion(subJson["date"].string!, format: "yyyy-MM-dd HH:mm:ss", region: paris)
            let dateInParis = DateInRegion(Date(), region: paris)
            let resultInMinutes = (date! - dateInParis)
            print(resultInMinutes)
            
            if resultInMinutes != nil {
                self.nextDiffInMinutes.append(resultInMinutes)
            } else {
                self.nextDiffInMinutes.append(0)
            }
            i = i + 1
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
        
        cell.push.text = localNotifs[indexPath.row]["content"].string
        
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
        
        
        if nextDiffInMinutes[indexPath.row] < 60 {
            
            oTitle = "Notification il y a \(nextDiffInMinutes[indexPath.row]) mn"
            oDescription = LocalData.Push.pushList[indexPath.row]
            Haptic.impact(.medium).generate()
            
            
            // Create Alet View Controller
            let alertController = CFAlertViewController(title: oTitle,
                                                        message: "\(oDescription) \r\n\r\n\r\n",
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
            
        } else {
            
            
            oTitle = "Notification il y a plus d'une heure"
            oDescription = LocalData.Push.pushList[indexPath.row]
            
            Haptic.impact(.medium).generate()
            
            // Create Alet View Controller
            let alertController = CFAlertViewController(title: oTitle,
                                                        message: oDescription,
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
                                                Haptic.notification(.success).generate()
            })
            
            // Add Action Button Into Alert
            alertController.addAction(defaultAction)
            
            // Present Alert View Controller
            present(alertController, animated: true, completion: nil)
        }
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

