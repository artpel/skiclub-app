//
//  LocalData.swift
//  Ski Club
//
//  Created by Arthur Péligry on 27/08/2018.
//  Copyright © 2018 Foxmob. All rights reserved.
//

import Foundation
import SwiftyJSON

struct LocalData {
    
    static var data = JSON()
    static var indexSelected = 0
    
// oldies goodies
        
    // static var data = [[String: Any]]()
    
    struct Push {
        
        static var pushList = [String]()
        static var timestamps = [String]()
    }
    
    struct Tombola {
        
        static var nomLot = [String]()
        static var nomVainqueur = [String]()
    }
    
    struct Urgences {
        
        static var nom = [String]()
        static var titre = [String]()
        static var numero = [String]()
    }
    
    struct Prix {
        
        static var nomPrix = [String]()
        static var descriptionPrix = [String]()
    }
    
    struct Pub {
        
        static var pubList = [String]()
        
        
        
    }
    
    struct Pratique {
        
        static var image = [String]()
        static var titre = [String]()
        static var section1 = [String]()
        static var urlDocBungalows = String()
        static var urlDocNavettes = String()
        
        struct Selected {
            static var image = String()
            static var titre = String()
            static var section1 = String()
            static var detailSelected = String()
            static var urlSelected = String()
        }
    }
    
    struct Programme {
        
        static var daysImages = [String]()
        static var selectedDay = String()
        static var nom = [String]()
        static var date = [String]()
        static var zone = [String]()
        static var image = [String]()
        static var heureDebut = [String]()
        static var heureFin = [String]()
        
    }
    
    
    struct Partenaires {
        
        static var image = [String]()
        static var titre = [String]()
        
        struct Selected {
            static var image = String()
            static var titre = String()
        }
    }
    
    struct Plan {
        
        static var nomPlan = [String]()
        static var latitude = [String]()
        static var longitude = [String]()
        static var position = [String]()
        static var delta = [String]()
        static var image = [String]()
        static var sousTitre = [String]()
        
        struct Selected {
            static var delta = "0.00098"
            static var nomPlan = String()
            static var latitude = "45.274077"
            static var longitude = "6.817068"
            static var image = String()
            static var sousTitre = String()
        }
    }
        
    

    
}
