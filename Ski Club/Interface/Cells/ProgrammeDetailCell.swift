//
//  DetailJourCellTableViewCell.swift
//  Adhenarcos
//
//  Created by Arthur Péligry on 03/12/2017.
//  Copyright © 2017 Foxmob. All rights reserved.
//

import UIKit

class ProgrammeDetailCell: UITableViewCell {
    
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var imageBla: UIImageView!
    
    @IBOutlet weak var heureDebut: UILabel!
    @IBOutlet weak var heureFin: UILabel!
    @IBOutlet weak var nomEvent: UILabel!
    @IBOutlet weak var zoneEvent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
