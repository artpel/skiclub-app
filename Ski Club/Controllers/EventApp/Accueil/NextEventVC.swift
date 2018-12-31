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
import FontAwesome_swift

class NextEventVC: UIViewController {
    
    @IBOutlet weak var timeImage: UIImageView!
    @IBOutlet weak var clockButton: UIButton!
    
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
  
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Database initialisation
        ref = Database.database().reference()
        
        clockButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .regular)
        clockButton.setTitle(String.fontAwesomeIcon(name: .clock), for: .normal)
        
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
            
//            self.activityIndicator.stopAnimating()
//            Animations.shake(viewGiven: viewNextEvent)
        } else {
            
            self.nomEvent.text = "Erreur, l'event est fini"
//            self.activityIndicator.stopAnimating()
//            
//            Animations.shake(viewGiven: viewNextEvent)
        }
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
