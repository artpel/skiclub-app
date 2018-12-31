//
//  PlanCell.swift
//  Ski Club
//
//  Created by Arthur Péligry on 31/12/2018.
//  Copyright © 2018 Foxmob. All rights reserved.
//

import UIKit
import FontAwesome_swift

class PlanCell: UITableViewCell {
    
    @IBOutlet weak var iconComp: UIButton!
    @IBOutlet weak var labelPlan: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconComp.titleLabel?.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        iconComp.setTitle(String.fontAwesomeIcon(name: .mapMarkerAlt), for: .normal)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
