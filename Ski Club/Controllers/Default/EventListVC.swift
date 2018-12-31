//
//  EventListVC.swift
//  Ski Club
//
//  Created by Arthur Péligry on 27/08/2018.
//  Copyright © 2018 Foxmob. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftyJSON
import Kingfisher
import DeckTransition
import Haptica
import NVActivityIndicatorView
import Hero

class EventListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Variable de référence à la Database Firebase
    var ref: DatabaseReference?
    
    @IBOutlet weak var eventList: UITableView!
    @IBOutlet weak var activityLoader: NVActivityIndicatorView!
    @IBOutlet weak var titleEvent: UILabel!
    @IBOutlet weak var logoSkiClub: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        loadData()
        
        eventList.isHidden = true
        titleEvent.isHidden = true
        logoSkiClub.isHidden = true
    
    }
    
    func redirectToEvent() {
        let storyboard = UIStoryboard(name: "Event", bundle: nil)
        if let tabbar = (storyboard.instantiateViewController(withIdentifier: "EventTabBar") as? UITabBarController) {
            
            tabbar.hero.modalAnimationType = .zoom
            self.hero.replaceViewController(with: tabbar)
        
        }
    }
    
    func loadData() {
        
        activityLoader.startAnimating()
        
        ref?.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if ( snapshot.value is NSNull ) {
                
            } else {
                
                if let value = snapshot.value as? [String: AnyObject] {
                    LocalData.data = JSON(value)
                }
                
                DispatchQueue.main.async(execute: {
                    self.eventList.reloadData()
                    
                    if LocalData.data["event"] == false {
                        self.redirectToEvent()
                    }
                    
                    self.activityLoader.stopAnimating()
                    self.eventList.isHidden = false
                    self.titleEvent.isHidden = false
                    self.logoSkiClub.isHidden = false
                    Animations.animateCells(tableView: self.eventList)
                    
                })
                
            }
            
        })
        
//        ref?.observe(.value) {
//            (snapshot: DataSnapshot) in
//
//            if ( snapshot.value is NSNull ) {
//
//            } else {
//
//                if let value = snapshot.value as? [String: AnyObject] {
//                    LocalData.data = JSON(value)
//                }
//
//                DispatchQueue.main.async(execute: {
//                    self.eventList.reloadData()
//
//                    if LocalData.data["event"] == false {
//                        self.redirectToEvent()
//                    }
//
//                    self.activityLoader.stopAnimating()
//                    self.eventList.isHidden = false
//                    self.titleEvent.isHidden = false
//                    self.logoSkiClub.isHidden = false
//                    Animations.animateCells(tableView: self.eventList)
//
//                })
//
//            }
//        }
        
    }
    
    // TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if LocalData.data == JSON.null {
            return 0
        } else {
            return LocalData.data["events"].count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eventCell = tableView.dequeueReusableCell(withIdentifier: "EventListCell") as! EventListCell
        
        eventCell.selectionStyle = .none
        tableView.rowHeight = 200
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        
        // Title
        eventCell.firstTitle.text = LocalData.data["events"][indexPath.row]["name"].string
        
        // Image
        let urlParsed = URL(string: LocalData.data["events"][indexPath.row]["imgUrl"].string!)
        let placeholder = UIImage(named: "placeholder.png")
        eventCell.imageTop?.kf.setImage(with: urlParsed, placeholder: placeholder)
        
        // Date
        eventCell.dateTitle.text = LocalData.data["events"][indexPath.row]["date"].string
    
        return eventCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        LocalData.indexSelected = indexPath.row
        
        Haptic.impact(.medium).generate()
        
        let detailView = EventDetailVC()
        let transitionDelegate = DeckTransitioningDelegate()
        detailView.transitioningDelegate = transitionDelegate
        detailView.modalPresentationStyle = .custom
        present(detailView, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
}
