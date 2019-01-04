//
//  PartenairesViewController.swift
//  Adhenarcos
//
//  Created by Arthur Péligry on 09/11/2017.
//  Copyright © 2017 Foxmob. All rights reserved.
//

import UIKit
import Kingfisher
import NVActivityIndicatorView
import Spring
import Haptica

class PartenairesVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var partenairesCollection: UICollectionView!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var titreView: UITextView!
    @IBOutlet weak var imageDetail: UIImageView!
    
    
    @IBAction func dismissDetails(_ sender: Any) {
        Haptic.notification(.success).generate()
        blurView.isHidden = true
    }
    
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blurView.frame = self.tabBarController!.view.bounds
        blurView.isHidden = true
        
        
        closeButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 20, style: .regular)
        closeButton.setTitle(String.fontAwesomeIcon(name: .timesCircle), for: .normal)
    }
    

    func changeImage(url: String) {
        if url == "" {
            
        } else {
            let urlOK = URL(string: url)!
            let placeholder = UIImage(named: "placeholder.png")
            self.imageDetail.kf.setImage(with: urlOK, placeholder: placeholder)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //LocalData.Partenaires.Selected.image = LocalData.Partenaires.image[indexPath.row]
        titreView.text = LocalData.data["eventData"]["partenaires"][indexPath.row]["description"].string!
        changeImage(url: LocalData.data["eventData"]["partenaires"][indexPath.row]["url"].string!)
        blurView.isHidden = false
        Haptic.impact(.light).generate()
        //tabBarController?.view.addSubview(blurView)

        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LocalData.data["eventData"]["partenaires"].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = partenairesCollection.dequeueReusableCell(withReuseIdentifier: "PartenairesCell", for: indexPath) as! PartenairesCell
        

        let url = URL(string: LocalData.data["eventData"]["partenaires"][indexPath.row]["url"].string!)!
        let processor = RoundCornerImageProcessor(cornerRadius: 50)
        let placeholder = UIImage(named: "placeholder.png")
        cell.imagePartenaire.kf.setImage(with: url, placeholder: placeholder, options: [.processor(processor)])

        return cell
    }
    
}
