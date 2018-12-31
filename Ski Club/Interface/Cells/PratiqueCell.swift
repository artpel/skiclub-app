//
//  PratiqueCell.swift
//  Ski Club
//
//  Created by Arthur Péligry on 31/12/2018.
//  Copyright © 2018 Foxmob. All rights reserved.
//

import UIKit

class PratiqueCell: UITableViewCell {

    @IBOutlet weak var imagePratique: UIImageView!
    @IBOutlet weak var labelPratique: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
