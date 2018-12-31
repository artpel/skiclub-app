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
import Firebase
import FirebaseDatabase

class ProgrammeVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Variable de référence à la Database Firebase
    var ref: DatabaseReference?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var daySelector: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Database initialisation
        ref = Database.database().reference()
        
        self.tableView.rowHeight = 160
        
        daySelector.addTarget(self, action: #selector(self.indexChanged(_:)), for: .valueChanged)
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            print("iOS");
        case 1:
            print("Android")
        case 2:
            print("Windows Phone")
        default:
            break
        }
    }
    
    
    // TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgrammeDetailCell", for: indexPath) as! ProgrammeDetailCell
        cell.selectionStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        
//        cell.nomEvent.text = LocalData.Programme.nom[indexPath.row]
//        cell.heureDebut.text = LocalData.Programme.heureDebut[indexPath.row]
//        cell.heureFin.text = LocalData.Programme.heureFin[indexPath.row]
//        cell.zoneEvent.text = LocalData.Programme.zone[indexPath.row]
//
//        let urlOk = URL(string: LocalData.Programme.image[indexPath.row])
//        let placeholder = UIImage(named: "pratique_placeholder.png")
//        cell.imageBla?.kf.setImage(with: urlOk, placeholder: placeholder)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
