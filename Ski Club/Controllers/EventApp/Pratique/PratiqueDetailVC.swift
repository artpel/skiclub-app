//
//  PratiqueDetailVC.swift
//  Ski Club
//
//  Created by Arthur Péligry on 02/01/2019.
//  Copyright © 2019 Foxmob. All rights reserved.
//

import UIKit
import Kingfisher
import SafariServices

class PratiqueDetailVC: UIViewController {

    @IBOutlet weak var imageTop: UIImageView!
    @IBOutlet weak var titleTop: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var ctaTitle: UILabel!
    @IBOutlet weak var bottomView: RoundShadowView!
    
    override func viewWillAppear(_ animated: Bool) {
        let indexSelected = LocalData.indexPratiqueSelected
        
        titleTop.text = LocalData.data["eventData"]["pratique"][indexSelected]["nom"].string!
        descriptionText.text = LocalData.data["eventData"]["pratique"][indexSelected]["description"].string!
        
        if LocalData.data["eventData"]["pratique"][indexSelected]["attachment"].exists() {
            bottomView.isHidden = false
            ctaTitle.text = LocalData.data["eventData"]["pratique"][indexSelected]["attachment"]["nom"].string!
        }
        
        // Image
        let urlParsed = URL(string: LocalData.data["eventData"]["pratique"][indexSelected]["img"].string!)
        let placeholder = UIImage(named: "placeholder.png")
        imageTop?.kf.setImage(with: urlParsed, placeholder: placeholder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        bottomView.addGestureRecognizer(tap)
        bottomView.isUserInteractionEnabled = true
        
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let url = URL(string: LocalData.data["eventData"]["pratique"][LocalData.indexPratiqueSelected]["attachment"]["url"].string!) else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
