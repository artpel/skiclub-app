//
//  AccueilViewController.swift
//  Adhenarcos
//
//  Created by Arthur Péligry on 09/11/2017.
//  Copyright © 2017 Foxmob. All rights reserved.
//

import UIKit
import Spring
import Firebase
import FirebaseDatabase
import Kingfisher
import Haptica
import CFAlertViewController
import ChameleonFramework
import RevealingSplashView

class AccueilVC: UIViewController {
    
    // Variable de référence à la Database Firebase
    var ref: DatabaseReference?
    
    let navigat = UINavigationBar()
    
    // Introduction
    
    @IBOutlet weak var bienvenue: RoundShadowView!
    
    var messageDeBienvenue = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. \n Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua."
    /*
    lazy var bulletinManager: BulletinManager =  {
        
        let page = PageBulletinItem(title: "Bienvenue aux Neptuniades 2018 !")
        page.descriptionText = messageDeBienvenue
        page.actionButtonTitle = "C'est parti"
        page.isDismissable = true
        page.actionHandler = { (item: PageBulletinItem) in
            self.bulletinManager.dismissBulletin(animated: true)
            Haptic.notification(.success).generate()
            self.navigat.isHidden = false
        }
        
        let rootItem: BulletinItem = page
        return BulletinManager(rootItem: rootItem)
        
    }()*/
    
    override func viewWillAppear(_ animated: Bool) {
        
        //self.noInternetConnection()
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Database initialisation
        ref = Database.database().reference()
        
      
        // Image dans la barre de titre
        // UI.setImageInTitle(nav: self.navigationItem)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.bienvenue.addGestureRecognizer(gesture)
        
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        
        Haptic.impact(.medium).generate()
        
        //bulletinManager.prepare()
        navigat.isHidden = true
        let  navController = self.tabBarController
        //bulletinManager.presentBulletin(above: navController!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
