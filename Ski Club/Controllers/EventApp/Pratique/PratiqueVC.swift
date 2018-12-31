//
//  EventListVC.swift
//  Ski Club
//
//  Created by Arthur Péligry on 27/08/2018.
//  Copyright © 2018 Foxmob. All rights reserved.
//

import UIKit

import SwiftyJSON
import Kingfisher
import DeckTransition
import Haptica
import NVActivityIndicatorView

class PratiqueVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var eventList: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if LocalData.data == JSON.null {
            return 0
        } else {
            return 3
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eventCell = tableView.dequeueReusableCell(withIdentifier: "PratiqueCell") as! PratiqueCell
        
        eventCell.selectionStyle = .none
        tableView.rowHeight = 200
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        
//        // Title
//        eventCell.firstTitle.text = LocalData.data["events"][indexPath.row]["name"].string
//
//        // Image
//        let urlParsed = URL(string: LocalData.data["events"][indexPath.row]["imgUrl"].string!)
//        let placeholder = UIImage(named: "placeholder.png")
//        eventCell.imageTop?.kf.setImage(with: urlParsed, placeholder: placeholder)
//
//        // Date
//        eventCell.dateTitle.text = LocalData.data["events"][indexPath.row]["date"].string
        
        return eventCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        LocalData.indexSelected = indexPath.row
//
//        Haptic.impact(.medium).generate()
//
//        let detailView = EventDetailVC()
//        let transitionDelegate = DeckTransitioningDelegate()
//        detailView.transitioningDelegate = transitionDelegate
//        detailView.modalPresentationStyle = .custom
//        present(detailView, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
