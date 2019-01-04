//
//  NextEventViewController.swift
//  Adhenarcos
//
//  Created by Arthur Péligry on 03/12/2017.
//  Copyright © 2017 Foxmob. All rights reserved.
//

import UIKit
import SwiftDate
import NVActivityIndicatorView
import Kingfisher
import FontAwesome_swift
import SwiftyJSON

class NextEventVC: UIViewController {
    
    @IBOutlet weak var clockButton: UIButton!

    var nextEvents = [[String:String]]()
    
    // IB Outlets
    
    @IBOutlet weak var timingEvent: UILabel!
    @IBOutlet weak var nomEvent: UILabel!
    @IBOutlet weak var zoneEvent: UILabel!
    @IBOutlet weak var timeEvent: UILabel!
    @IBOutlet weak var imageEvent: UIImageView!
  
    
    override func viewDidAppear(_ animated: Bool) {
        checkDate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clockButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .regular)
        clockButton.setTitle(String.fontAwesomeIcon(name: .clock), for: .normal)
        
    }
    
    func checkDate() {
        
        self.nextEvents.removeAll()
        
        var jourEvent = 0
        
        if Date().day == 12 {
            jourEvent = 1
        } else if Date().day == 13 {
            jourEvent = 2
        } else {
            
        }
        
        let lastDay = "2019-01-14 00:00"
        
        let paris = Region(calendar: Calendars.gregorian, zone: Zones.europeParis, locale: Locales.french)
        
        for (key,subJson):(String, JSON) in LocalData.data["eventData"]["programme"][jourEvent] {
            
            let datum = subJson["dateDebut"].string!
            let dateEtHeure = String(describing: datum.suffix(5))
            
            
            let date = try! DateInRegion(datum, format: "yyyy-MM-dd HH:mm", region: paris)
            let derniereDate = try! DateInRegion(lastDay, format: "yyyy-MM-dd HH:mm", region: paris)
            let dateInParis = DateInRegion(Date(), region: paris)
            
            if dateInParis >= derniereDate! {
                
            } else {
                let resultInMinutes = String(describing: dateInParis.getInterval(toDate: date, component: .minute))
                
                let minuti = date!.minute
                var minutiString = String()
                
                if minuti == 0 {
                    minutiString = "00"
                } else {
                    minutiString = String(describing: minuti)
                }
                
                
                let nextEvent = [
                    "nom": subJson["title"].string!,
                    "dateDebut": subJson["dateDebut"].string!,
                    "zone": subJson["lieu"].string!,
                    "img": subJson["img"].string!,
                    "diff": resultInMinutes,
                    "heure": dateEtHeure
                    ] as [String : String]
                
                self.nextEvents.append(nextEvent)
            }
            
            
            
        }
        
        self.changeEvent()
        
    }
    
    func changeEvent() {
        
        
        if nextEvents.count != 0 {
            
            let event = nextEvents[0]
            let diffInMinutes = Int(event["diff"]!)!
            
            
            if diffInMinutes > 120 {
                self.timingEvent.text = "> 2h"
            }
            if diffInMinutes <= 120 && diffInMinutes > 60 {
                self.timingEvent.text = "> 1h"
            }
            if diffInMinutes <= 60 {
                self.timingEvent.text = "\(diffInMinutes) mn"
            }
            
            
            
            let urlOk = URL(string: event["img"]!)
            let placeholder = UIImage(named: "placeholder.png")
            imageEvent?.kf.setImage(with: urlOk, placeholder: placeholder)
            
            self.nomEvent.text = event["nom"]
            self.zoneEvent.text = event["zone"]
            self.timeEvent.text = "À \(String(describing: event["heure"]!))"
            

        } else {
            
            self.nomEvent.text = "L'event est fini"
            self.zoneEvent.text = "Merci de votre participation !"
            self.timeEvent.text = ""
            self.timingEvent.text = ""
        }
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
