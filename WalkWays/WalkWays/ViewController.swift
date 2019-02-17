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

    private let locationManager = CLLocationManager();
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureLocationServices();
    }
    
    

    private func configureLocationServices(){
        locationManager.delegate = self;
        
        if(CLLocationManager.authorizationStatus() == .notDetermined){
            
            locationManager.requestAlwaysAuthorization(); //allways using location - we can change this if we want
        }
    }
}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        <#code#>
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        <#code#>
    }
}

