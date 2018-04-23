//
//  RunMapViewController.swift
//  Run
//
//  Created by Douglas Taquary on 08/04/2018.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class RunMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var startButton: UIButton!
    
    /// MARK: - Location
    let locationManager = CLLocationManager()
}

extension RunMapViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            //locationManager.distanceFilter
        } else {
            print("Need to Enable Location")
        }
        
        let location = CLLocationCoordinate2D()
        let viewRegion = MKCoordinateRegionMakeWithDistance(location, 1000, 1000)
        mapView.setRegion(viewRegion, animated: true)
    }
}

extension RunMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("\(locations)")
    }

}
