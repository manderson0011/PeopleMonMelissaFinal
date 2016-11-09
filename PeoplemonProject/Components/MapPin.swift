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
    var person: People?
    
    init(person: People) {
        self.person = person
        if let lat = person.latitude, let long = person.longitude {
            self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        } else {
            self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }
}
