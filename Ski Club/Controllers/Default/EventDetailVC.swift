//
//  EventDetailVC.swift
//  Ski Club
//
//  Created by Arthur Péligry on 27/08/2018.
//  Copyright © 2018 Foxmob. All rights reserved.
//

import UIKit
import Kingfisher
import ImageSlideshow
import SafariServices

class EventDetailVC: UIViewController {
    
    @IBOutlet weak var descriptionText: UITextView!
    
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var titleTop: UILabel!
    @IBOutlet weak var bottomView: RoundShadowView!
    
    var slideShowImages = [InputSource]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let indexSelected = LocalData.indexEventSelected
        setSlideshow(indexSelected: indexSelected)
        
        titleTop.text = LocalData.data["events"][indexSelected]["name"].string!
        descriptionText.text = LocalData.data["events"][indexSelected]["description"].string!
        
        if LocalData.data["events"][indexSelected]["url"].string! == "" {
            bottomView.isHidden = true
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        bottomView.addGestureRecognizer(tap)
        bottomView.isUserInteractionEnabled = true
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let url = URL(string: LocalData.data["events"][LocalData.indexEventSelected]["url"].string!) else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    func setSlideshow(indexSelected: Int) {
        
        var i = 0
        for _ in LocalData.data["events"][indexSelected]["slideshow"] {
            
            slideShowImages.append(KingfisherSource(urlString: LocalData.data["events"][indexSelected]["slideshow"][i].string!)!)
            i += 1
        }
        
        slideShow.setImageInputs(slideShowImages)
        slideShow.activityIndicator = DefaultActivityIndicator()
        slideShow.slideshowInterval = 4
        slideShow.contentScaleMode = .scaleAspectFill
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

}
