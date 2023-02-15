//
//  LocationFetcher.swift
//  FaceSnap
//
//  Created by Edwin Przeźwiecki Jr. on 14/02/2023.
//

import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
