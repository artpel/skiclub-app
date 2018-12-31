//
//  AccueilViewController.swift
//  Adhenarcos
//
//  Created by Arthur Péligry on 09/11/2017.
//  Copyright © 2017 Foxmob. All rights reserved.
//

import UIKit
import Kingfisher
import Haptica
import CFAlertViewController
import ChameleonFramework

class AccueilVC: UIViewController {
    
    @IBOutlet weak var chevron: UIButton!

    @IBOutlet weak var bienvenue: RoundShadowView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        chevron.titleLabel?.font = UIFont.fontAwesome(ofSize: 15, style: .solid)
        chevron.setTitle(String.fontAwesomeIcon(name: .chevronRight), for: .normal)
      
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.bienvenue.addGestureRecognizer(gesture)
     
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        
        Haptic.impact(.medium).generate()
        
        let alertController = CFAlertViewController(title: "Bienvenue à l'Adhémar",
                                                    message: LocalData.data["eventData"]["messageAccueil"].string!,
                                                    textAlignment: .left,
                                                    preferredStyle: .notification,
                                                    didDismissAlertHandler: nil)
       
        let defaultAction = CFAlertAction(title: "Merci",
                                          style: .Default,
                                          alignment: .right,
                                          backgroundColor: UIColor(red: CGFloat(46.0 / 255.0), green: CGFloat(204.0 / 255.0), blue: CGFloat(113.0 / 255.0), alpha: CGFloat(1)),
                                          textColor: nil,
                                          handler: { (action) in

        })
        
       
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
