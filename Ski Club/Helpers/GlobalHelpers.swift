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

struct GlobalHelpers {
    
    static func noInternetConnection() {
        
        if Reachability.isConnectedToNetwork() {
            
        } else {
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
            
            alertController.addAction(defaultAction)
            //present(alertController, animated: true, completion: nil)
        }
        
    }
    
}
