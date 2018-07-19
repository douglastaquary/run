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

        } else {
            print("Need to Enablbree Location")
        }
        
        let location = CLLocationCoordinate2D(latitude: Double(-23.550001), longitude: Double(-46.636878))
        let viewRegion = MKCoordinateRegionMakeWithDistance(location, 1000, 1000)
        mapView.setRegion(viewRegion, animated: true)
        mapView.showsUserLocation = true
    }
}

extension RunMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("\(locations)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest

        default:
            break
        }
    }

}
