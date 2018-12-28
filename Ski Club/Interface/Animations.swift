//
//  File.swift
//  Ski Club
//
//  Created by Arthur Péligry on 27/08/2018.
//  Copyright © 2018 Foxmob. All rights reserved.
//

import Foundation
import UIKit

class Animations {
   
    static func animateCells(tableView: UITableView) {
        // Animation
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.25, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
}
