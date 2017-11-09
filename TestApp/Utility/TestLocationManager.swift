//
//  TestLocationManager.swift
//  TestApp
//
//  Created by Vanita on 11/9/17.
//  Copyright © 2017 Tixdo. All rights reserved.
//

import Foundation
import CoreLocation

protocol TestLocationManagerDelegate {
    func testLocationManager(_ testLocationManager: TestLocationManager, locationUpdated: Bool)
}

class TestLocationManager: CLLocationManager, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    var lattitude: CLLocationDegrees? = 18.5204
    var longitude: CLLocationDegrees? = 73.8567
    var testLocationManagerDelegate: TestLocationManagerDelegate?
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        
        //get the last location:
        let location = locations.last
        lattitude = location?.coordinate.latitude
        longitude = location?.coordinate.longitude
        
        self.testLocationManagerDelegate?.testLocationManager(self, locationUpdated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.testLocationManagerDelegate?.testLocationManager(self, locationUpdated: false)
    }
}
