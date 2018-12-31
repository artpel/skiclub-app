//
//  ProgrammeViewController.swift
//  Adhenarcos
//
//  Created by Arthur Péligry on 09/11/2017.
//  Copyright © 2017 Foxmob. All rights reserved.
//

import UIKit
import Kingfisher
import NVActivityIndicatorView
import SwiftDate

class ProgrammeVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var daySelector: UISegmentedControl!
    
    var daySelected = 0
    
    let paris = Region(calendar: Calendars.gregorian, zone: Zones.europeParis, locale: Locales.french)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 200
        
        daySelector.addTarget(self, action: #selector(self.indexChanged(_:)), for: .valueChanged)
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            daySelected = 0
            self.tableView.reloadData()
        case 1:
            daySelected = 1
            self.tableView.reloadData()
        case 2:
            daySelected = 2
            self.tableView.reloadData()
        default:
            break
        }
    }
    
    
    // TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalData.data["eventData"]["programme"][daySelected].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgrammeDetailCell", for: indexPath) as! ProgrammeDetailCell
        cell.selectionStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        
        cell.nomEvent.text = LocalData.data["eventData"]["programme"][daySelected][indexPath.row]["title"].string
        cell.zoneEvent.text = LocalData.data["eventData"]["programme"][daySelected][indexPath.row]["lieu"].string
        
        let url = URL(string: LocalData.data["eventData"]["programme"][daySelected][indexPath.row]["img"].string!)
        let placeholder = UIImage(named: "placeholder.png")
        cell.imageEvent?.kf.setImage(with: url, placeholder: placeholder)
        
        let dateDebut = try! DateInRegion(LocalData.data["eventData"]["programme"][daySelected][indexPath.row]["dateDebut"].string!, format: "yyyy-MM-dd HH:mm:ss", region: paris)
        let dateFin = try! DateInRegion(LocalData.data["eventData"]["programme"][daySelected][indexPath.row]["dateFin"].string!, format: "yyyy-MM-dd HH:mm:ss", region: paris)
        
        cell.heureDebut.text = String(describing: dateDebut!.hour) + ":" + String(describing: dateDebut!.minute)
        cell.heureFin.text = String(describing: dateFin!.hour) + ":" + String(describing: dateFin!.minute)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
