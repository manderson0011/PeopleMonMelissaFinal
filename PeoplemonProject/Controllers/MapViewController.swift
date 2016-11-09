//
//  MapViewController.swift
//  PeoplemonProject
//
//  Created by Melissa Anderson on 11/8/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//

import Foundation
import MapKit
import MBProgressHUD
import CoreLocation

class MapViewController: UIViewController {

@IBOutlet weak var mapView: MKMapView!




override func viewDidLoad() {
    super.viewDidLoad()
    print("view loaded")
    // Do any additional setup after loading the view.
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print("view appeared")
    if !WebServices.shared.userAuthTokenExists() || WebServices.shared.userAuthTokenExpired(){
        performSegue(withIdentifier: "PresentLoginNoAnimation", sender: self)
    print("I got here")
    }
}
//Mark - @IBActions
@IBAction func logout(_ sender: Any) {
    UserStore.shared.logout{
        self.performSegue(withIdentifier: "PresentLogin", sender: self)
    }
    
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

}
