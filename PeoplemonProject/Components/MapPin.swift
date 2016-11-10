//
//  MapPin.swift
//  PeoplemonProject
//
//  Created by Melissa Anderson on 11/9/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapPin: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var people: People?
    var userName: String?
    var userId: String?
    var title: String?
    
    init(people: People) {
        self.people = people
        self.title = people.userName
        self.userId = people.userId
        
        
        if let lat = people.latitude, let long = people.longitude {
            self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        } else {
            self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
            
        }
    }
}
