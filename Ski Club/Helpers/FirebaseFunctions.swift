//
//  FirebaseFunctions.swift
//  Ski Club
//
//  Created by Arthur Péligry on 31/12/2018.
//  Copyright © 2018 Foxmob. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftyJSON

struct FirebaseFunctions {
    
    static func getDataOnce() {
        
        var ref: DatabaseReference?
        ref = Database.database().reference()
        
        ref?.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if ( snapshot.value is NSNull ) {
                
            } else {
                
                if let value = snapshot.value as? [String: AnyObject] {
                    LocalData.data = JSON(value)
                }
            }
        })
    }
    
}
