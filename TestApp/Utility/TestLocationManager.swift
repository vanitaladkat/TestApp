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
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func testCondition(str: String?) {
        guard let str = str else {
            return
        }
        
        print(str)
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


/*
 Frame specifications based on high level understanding of the problem statement and develop the code.
 Develop, write and implement iOS applications following established architecture standards as well as software development and project management methodologies.
 Implementing low level solutions for business problems.
 Write high quality code using the guidelines and effectively debug the code.
 Document the code changes, package the code, and unit test it.
 Perform code review of junior members.
 Perform the task assigned and implement a solution.
 Work with the application development team in delivering the project and deliverables within time and good quality.
 Assess requirements for new and enhanced functionalities; identify impact on existing applications, operating systems, hardware and networks.
 Perform unit testing, ensure quality assurance of applications through system testing.
 Keep up-to date with latest technologies, trends and provides inputs/recommendations to project manager or the architect as required.
 Coordinate and communicate with the other tracks and disciplines involved in the project.
 
 Candidate Profile
 Education: B.E. / B.Tech / MCA / MCS
 Experience: Overall 4 to 7 years of experience out of which at least 3+ years should be in iOS Application Development.
 Knowledge and Skills:
 Good experience in iOS application development.
 Must have good experience in Objective C, Xcode 7, and iOS 8 and above. Familiarity with Swift (2.3/3.0) will be preferred.
 Good experience in UI development is a must. Good understanding of Storyboards, Dynamic Layout, Size Classes is desirable.
 Familiarity with any of CoreData, sqlite, realm etc is desirable.
 Good understanding of version control systems like Git, SVN is desirable. Familiarity with dependency managers like Cocoapods, Carthage will be preferred.
 Familiarity with Provisioning Profiles, Signing Identities, Ad Hoc Distribution etc is desirable.
 Prior experience on enterprise mobility solutions is a must.
 Experience in developing and delivering solutions utilizing Service Oriented Architecture.
 Understanding of modern development methodologies and tools including Agile (XP and Scrum), Rapid Application Development, etc. Familiarity with Project Management Tools like Confluence, JIRA, TFS etc is desirable.
 Excellent Communication, presentation, problem-solving and team working skills.
 */
