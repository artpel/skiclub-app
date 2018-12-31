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
    @IBOutlet weak var detailView: SpringView!
    
    @IBOutlet weak var titreView: UITextView!
    
    var partenaire = [String]()
    
    @IBAction func dismissDetails(_ sender: Any) {
        Haptic.notification(.success).generate()
        Animations.fadeOut(viewGiven: detailView)
        blurView.isHidden = true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //blurView.frame = self.tabBarController!.view.bounds
        //blurView.isHidden = true
        //detailView.layer.cornerRadius = 20
        
    }
    
   
    @IBOutlet weak var imageDetail: UIImageView!
   
    func changeImage(url: String) {
        if url == "" {
            ///noInternetConnection()
        } else {
            let urlOK = URL(string: url)!
            let placeholder = UIImage(named: "partenaires_placeholder.png")
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
        
        LocalData.Partenaires.Selected.image = LocalData.Partenaires.image[indexPath.row]
        titreView.text = LocalData.Partenaires.titre[indexPath.row]
        changeImage(url: LocalData.Partenaires.image[indexPath.row])
        blurView.isHidden = false
        Haptic.impact(.light).generate()
        tabBarController?.view.addSubview(blurView)
        Animations.pop(viewGiven: detailView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 150
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = partenairesCollection.dequeueReusableCell(withReuseIdentifier: "PartenairesCell", for: indexPath) as! PartenairesCell
        
//
//        let url = URL(string: LocalData.Partenaires.image[indexPath.row])!
//        let processor = RoundCornerImageProcessor(cornerRadius: 50)
//        let placeholder = UIImage(named: "partenaires_placeholder.png")
//        cell.imagePartenaire.kf.setImage(with: url, placeholder: placeholder, options: [.processor(processor)])
//
        return cell
    }
    
}
