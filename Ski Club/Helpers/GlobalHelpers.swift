//
//  GlobalHelpers.swift
//  Ski Club
//
//  Created by Arthur Péligry on 28/12/2018.
//  Copyright © 2018 Foxmob. All rights reserved.
//

import Foundation
import UIKit
import CFAlertViewController
import ChameleonFramework


struct GlobalHelpers {
    
    static func noInternetConnection() {
        /*
        let reachability = Reachability()!
        
        reachability.whenUnreachable = { _ in
            // Create Alet View Controller
            let alertController = CFAlertViewController(title: "Pas de connexion internet",
                                                        message: "Vous devez être connectés à Internet pour utiliser l'app",
                                                        textAlignment: .left,
                                                        preferredStyle: .alert,
                                                        didDismissAlertHandler: nil)
            
            let defaultAction = CFAlertAction(title: "Ça roule !",
                                              style: .Default,
                                              alignment: .right,
                                              backgroundColor: HexColor("C00011"),
                                              textColor: HexColor("ffffff"),
                                              handler: { (action) in
                                                Haptic.notification(.error).generate()
            })
        }
        
        if reachability.isConnectedToNetwork() {
            
        } else {
            
            
            alertController.addAction(defaultAction)
            //present(alertController, animated: true, completion: nil)
        }*/
        
    }
    
}
