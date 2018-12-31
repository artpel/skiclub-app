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

class PlanVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // IB Outlets
    @IBOutlet weak var listPlan: UITableView!
    
    @IBOutlet weak var planStation: MKMapView!
    
    // Location Manager
    var locationManager = CLLocationManager()
    
    struct Selected {
        static var delta = "0.00300"
        static var nomPlan = String()
        static var latitude = "45.274077"
        static var longitude = "6.817068"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listPlan.rowHeight = 70
    
        setMap(latitude: Selected.latitude, longitude: Selected.longitude, deltaLat: Selected.delta, deltaLong: Selected.delta)
        startLocationServices()
        
        loadAnnotations()
        
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

    func createAnnotation(i: Int) {

        let annotation = MKPointAnnotation()
        annotation.title = LocalData.data["eventData"]["plan"][i]["title"].string!
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: LocalData.data["eventData"]["plan"][i]["lat"].double!, longitude: LocalData.data["eventData"]["plan"][i]["long"].double!)
        annotation.coordinate = location
        self.planStation.addAnnotation(annotation)
    }

    func loadAnnotations() {
        var i = 0
        while i < LocalData.data["eventData"]["plan"].count {
            createAnnotation(i: i)
            i += 1
        }
    }
    
    // Table View

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalData.data["eventData"]["plan"].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = listPlan.dequeueReusableCell(withIdentifier: "PlanCell", for: indexPath) as! PlanCell
        cell.selectionStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none // OK

        cell.labelPlan.text = LocalData.data["eventData"]["plan"][indexPath.row]["title"].string!

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        Selected.latitude = String(describing: LocalData.data["eventData"]["plan"][indexPath.row]["lat"].double!)
        Selected.longitude = String(describing: LocalData.data["eventData"]["plan"][indexPath.row]["long"].double!)
        Selected.delta = String(describing: LocalData.data["eventData"]["plan"][indexPath.row]["delta"].double!)

        Haptic.impact(.light).generate()

        setMap(latitude: Selected.latitude, longitude: Selected.longitude, deltaLat: Selected.delta, deltaLong: Selected.delta)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
}
