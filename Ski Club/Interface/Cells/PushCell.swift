//
//  PushCell.swift
//  Adhenarcos
//
//  Created by Arthur Péligry on 07/12/2017.
//  Copyright © 2017 Foxmob. All rights reserved.
//

import UIKit

class PushCell: UITableViewCell {

    @IBOutlet weak var push: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
