//
//  ViewController.swift
//  WalkWays
//
//  Created by Abhiram Santhosh on 2/17/19.
//  Copyright © 2019 WalkWays. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    private let locationManager = CLLocationManager();
    private var currentCoordinate: CLLocationCoordinate2D?;
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureLocationServices();
        searchBar.barTintColor = .white;
        //searchBar.searchBarStyle = .minimal;
    }
    
    

    private func configureLocationServices(){
        locationManager.delegate = self;
        
        let status = CLLocationManager.authorizationStatus();
        
        if( status == .notDetermined){
            
            locationManager.requestAlwaysAuthorization(); //allways using location - we can change this if we want
        } else if (status == .authorizedAlways || status == .authorizedWhenInUse){
            //else
            beginLocationUpdates(locationManager: locationManager);
            
        }
    }
    
    private func zoomToLatestLocation(with coordinate:CLLocationCoordinate2D){
        
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000);
        mapView.setRegion(zoomRegion, animated: true);
    }
    
    private func beginLocationUpdates(locationManager: CLLocationManager){
        mapView.showsUserLocation = true;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest; //accuracy of location data
        locationManager.startUpdatingLocation();
    }
}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else { return }
        
        if(currentCoordinate == nil){
            zoomToLatestLocation(with: latestLocation.coordinate); //zoom to current location
        }
        
        currentCoordinate = latestLocation.coordinate; //set location
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedAlways || status == .authorizedWhenInUse){
            beginLocationUpdates(locationManager: manager);
        }
    }
}

