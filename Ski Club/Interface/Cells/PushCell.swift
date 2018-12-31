//
//  PushCell.swift
//  Adhenarcos
//
//  Created by Arthur Péligry on 07/12/2017.
//  Copyright © 2017 Foxmob. All rights reserved.
//

import UIKit
import FontAwesome_swift
import ChameleonFramework

class PushCell: UITableViewCell {

    @IBOutlet weak var push: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var chevron: UIButton!
    @IBOutlet weak var clock: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        chevron.titleLabel?.font = UIFont.fontAwesome(ofSize: 15, style: .solid)
        chevron.setTitle(String.fontAwesomeIcon(name: .chevronRight), for: .normal)
        
        clock.titleLabel?.font = UIFont.fontAwesome(ofSize: 15, style: .regular)
        clock.setTitle(String.fontAwesomeIcon(name: .clock), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
