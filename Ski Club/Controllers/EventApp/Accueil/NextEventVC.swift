//
//  NextEventViewController.swift
//  Adhenarcos
//
//  Created by Arthur Péligry on 03/12/2017.
//  Copyright © 2017 Foxmob. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftDate
import NVActivityIndicatorView
import Spring
import Kingfisher
import ChameleonFramework

class NextEventVC: UIViewController {
    
    @IBOutlet weak var timeImage: UIImageView!
    
    // Variable de référence à la Database Firebase
    var ref: DatabaseReference?
    
    var nextEvents = [Int]()
    
    var nextDiffInMinutes = [Double]()
    
    // IB Outlets
    
    @IBOutlet weak var timingEvent: UILabel!
    @IBOutlet weak var nomEvent: UILabel!
    @IBOutlet weak var zoneEvent: UILabel!
    @IBOutlet weak var timeEvent: UILabel!
    @IBOutlet weak var imageEvent: UIImageView!
    @IBOutlet weak var viewNextEvent: SpringView!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    @IBOutlet weak var masqueImage: UIView!
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewNextEvent.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Database initialisation
        ref = Database.database().reference()
        
        viewNextEvent.isHidden = true
        
    }
    
    func checkDate() {
        
        self.nextEvents.removeAll()
        self.nextDiffInMinutes.removeAll()
        
        let paris = Region(calendar: Calendars.gregorian, zone: Zones.europeParis, locale: Locales.french)
        
        var i = 0
        for element in LocalData.Programme.date {
            
            let date = try! DateInRegion(element, format: "yyyy-MM-dd HH:mm:ss", region: paris)
            let dateInParis = DateInRegion(Date(), region: paris)
            
            if dateInParis < date! {
                self.nextEvents.append(i)
                
                let dateDifference = (date! - dateInParis)
                if dateDifference == nil {
                    
                } else {
                    self.nextDiffInMinutes.append(dateDifference)
                }
            } else {
                
            }
            
            i += 1
            
        }
        
        self.changeEvent()
        
    }
    
    func changeEvent() {
        
        if nextEvents.count != 0 {
            let index = nextEvents[0]
            if nextDiffInMinutes != nil {
                let diffInMinutes = nextDiffInMinutes[0]
                
                if diffInMinutes > 120 {
                    self.timingEvent.text = "> 2h"
                }
                if diffInMinutes <= 120 && diffInMinutes > 60 {
                    self.timingEvent.text = "> 1h"
                }
                if diffInMinutes <= 60 {
                    self.timingEvent.text = "\(diffInMinutes) mn"
                }
                
            } else {
                self.timingEvent.text = "Go"
            }
            
            
            let urlOk = URL(string: LocalData.Programme.image[index])
            let placeholder = UIImage(named: "pratique_placeholder.png")
            imageEvent?.kf.setImage(with: urlOk, placeholder: placeholder)
            
            self.nomEvent.text = LocalData.Programme.nom[index]
            self.zoneEvent.text = LocalData.Programme.zone[index]
            self.timeEvent.text = "À \(LocalData.Programme.heureDebut[index])"
            
            self.activityIndicator.stopAnimating()
            Animations.shake(viewGiven: viewNextEvent)
        } else {
            
            self.nomEvent.text = "Erreur, l'event est fini"
            self.activityIndicator.stopAnimating()
            
            Animations.shake(viewGiven: viewNextEvent)
        }
        
    }
    
    
    func loadData() {
        
        self.activityIndicator.startAnimating()
        
        let paris = Region(calendar: Calendars.gregorian, zone: Zones.europeParis, locale: Locales.french)
        let dateInParis = DateInRegion(Date(), region: paris)
        var jourEvent = String()
        if dateInParis.day == 19 {
            jourEvent = "jour2"
        } else if dateInParis.day == 20 {
            jourEvent = "jour3"
        }  else if dateInParis.day == 21 {
            jourEvent = "jour4"
        } else {
            jourEvent = "jour1"
        }
        
        ref?.child("programme").child(jourEvent).observe(.value) {
            (snapshot: DataSnapshot) in
            
            if ( snapshot.value is NSNull ) {
                // self.noInternetConnection()
            } else {
                
                LocalData.Programme.nom.removeAll()
                LocalData.Programme.zone.removeAll()
                LocalData.Programme.image.removeAll()
                LocalData.Programme.heureDebut.removeAll()
                LocalData.Programme.heureFin.removeAll()
                LocalData.Programme.date.removeAll()
                
                for child in snapshot.children {
                    let snap = child as! DataSnapshot //each child is a snapshot
                    let dict = snap.value as! [String: Any] // the value is a dict
                    LocalData.Programme.nom.append(dict["nom"] as! String)
                    LocalData.Programme.zone.append(dict["zone"] as! String)
                    LocalData.Programme.image.append(dict["image"] as! String)
                    LocalData.Programme.heureDebut.append(dict["heureDebut"] as! String)
                    LocalData.Programme.heureFin.append(dict["heureFin"] as! String)
                    LocalData.Programme.date.append(dict["date"] as! String)
                    
                    
                }
                
                DispatchQueue.main.async(execute: {
                    
                    self.checkDate()
                    
                })
                
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
