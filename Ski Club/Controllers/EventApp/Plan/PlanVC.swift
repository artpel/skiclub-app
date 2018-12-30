//
//  PlanVC.swift
//  Adhenarcos
//
//  Created by Arthur Péligry on 10/11/2017.
//  Copyright © 2017 Foxmob. All rights reserved.
//

import UIKit
import Haptica
import MapKit
import CoreLocation
import Spring
import Kingfisher
import NVActivityIndicatorView

class PlanVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // IB Outlets
    @IBOutlet weak var mapCollection: UITableView!
    
    @IBOutlet weak var planStation: MKMapView!
    
    // Location Manager
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setImageInTitle()
        
//        // Do any additional setup after loading the view.
//        mapCollection.backgroundColor = UIColor.clear
//        self.mapCollection.rowHeight = 100
//        mapCollection.isHidden = true
        
        
        // setMap(latitude: LocalData.Plan.Selected.latitude, longitude: LocalData.Plan.Selected.longitude, deltaLat: LocalData.Plan.Selected.delta, deltaLong: LocalData.Plan.Selected.delta)
        startLocationServices()
        
    }
    
    func setImageInTitle() {
        var titleView : UIImageView
        // set the dimensions you want here
        titleView = UIImageView(frame:CGRect(x:-10,y:0,width:40,height:40))
        // Set how do you want to maintain the aspect
        titleView.contentMode = .scaleAspectFit
        titleView.image = UIImage(named: "header_adhenarcos.png")
        self.navigationItem.titleView = titleView
    }
    
    func startLocationServices() {
        
        //Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestWhenInUseAuthorization()
        }
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.startUpdatingLocation()
        }
        
        DispatchQueue.main.async {
            
            // Location
            self.planStation.delegate = self
            self.planStation.showsUserLocation = true
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.delegate = self
            self.locationManager.startUpdatingLocation()
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func setMap(latitude: String, longitude: String, deltaLat: String, deltaLong: String) {
        
        let momentaryLatitude = Double(latitude)
        let momentaryLongitude = Double(longitude)
        
        let latitude:CLLocationDegrees = momentaryLatitude!
        let long:CLLocationDegrees = momentaryLongitude!
        let latDelta:CLLocationDegrees = Double(deltaLat)!
        let longDelta:CLLocationDegrees = Double(deltaLong)!
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: long)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        self.planStation.setRegion(region, animated: true)
        self.planStation.mapType = MKMapType.hybrid;
    }
//
//    func createAnnotation(i: Int) {
//
//         let annotation = MKPointAnnotation()
//         annotation.title = LocalData.Plan.nomPlan[i]
//
//         let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
//         annotation.coordinate = location
//         // self.planStation.addAnnotation(annotation)
//    }
////
//    func loadAnnotations() {
//        var i = 0
//        while i < LocalData.Plan.nomPlan.count {
//            createAnnotation(i: i)
//            i += 1
//        }
//    }
//    
//
//
//    // Table View
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return LocalData.Plan.nomPlan.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = mapCollection.dequeueReusableCell(withIdentifier: "PlanCell", for: indexPath) as! PlanCell
//        cell.selectionStyle = .none
//        tableView.backgroundColor = UIColor.clear
//        tableView.separatorStyle = .none // OK
//
//        cell.titreCell.text = LocalData.Plan.nomPlan[indexPath.row]
//        cell.sousTitre.text = LocalData.Plan.sousTitre[indexPath.row]
//
//        let urlOk = URL(string: LocalData.Plan.image[indexPath.row])
//        let placeholder = UIImage(named: "partenaires_placeholder_white.png")
//        cell.imageCell.kf.setImage(with: urlOk, placeholder: placeholder)
//
//
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        LocalData.Plan.Selected.latitude = LocalData.Plan.latitude[indexPath.row]
//        LocalData.Plan.Selected.longitude = LocalData.Plan.longitude[indexPath.row]
//        LocalData.Plan.Selected.delta = LocalData.Plan.delta[indexPath.row]
//        let lat = Double(LocalData.Plan.Selected.latitude)!
//        let long = Double(LocalData.Plan.Selected.longitude)!
//        let delta = Double(LocalData.Plan.Selected.delta)!
//        planStationMapView.setCenter(CLLocationCoordinate2D(latitude: lat, longitude: long), zoomLevel: delta, animated: true)
//        Haptic.impact(.light).generate()
//
//        setMap(latitude: LocalData.Plan.Selected.latitude, longitude: LocalData.Plan.Selected.longitude, deltaLat: LocalData.Plan.Selected.delta, deltaLong: LocalData.Plan.Selected.delta)
//    }
//
    
}
