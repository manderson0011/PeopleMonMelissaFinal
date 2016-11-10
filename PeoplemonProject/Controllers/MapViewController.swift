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


class MapViewController: UIViewController, CLLocationManagerDelegate{
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var updateLocation = 0
    
    var nearbyPeople = [People]()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        
        self.locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus()
            == .authorizedWhenInUse {
            self.mapView.showsUserLocation = true
            self.locationManager.startUpdatingLocation()
            
        }else{
            self .locationManager.requestWhenInUseAuthorization()
        }
        

        
    }
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let mySpace = MKCoordinateRegionMakeWithDistance(self.locationManager.location!.coordinate, 1000, 1000)
        self.mapView.setRegion(mySpace, animated: true)
        
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
    
    
    func loadNearbyPeople (){
        //create a people object of type .nearby
        let nearbyPerson = People(radius: 100)
        
        //call webservices.getobjects
        WebServices.shared.getObjects(nearbyPerson) { (everyoneNearby, error) in
            if let everyoneNearby = everyoneNearby {
                //store result in array above
                self.nearbyPeople = everyoneNearby
               // show pins on map
                self.pinsOnMap()
                
            }
        }
    }
    
    func pinsOnMap() {
        for person in nearbyPeople
        {
            let annotation = MKAnnotation()
            self.mapView.annotations.append(annotation)
        }
    }
    
    
    //Mark - @IBActions
    @IBAction func logout(_ sender: Any) {
        UserStore.shared.logout{
            self.performSegue(withIdentifier: "PresentLogin", sender: self)
        }
        
    }
    
    @IBAction func userCheckIn(_ sender: Any) {
        if let location = locationManager.location {
            let people = People(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            WebServices.shared.postObject(people, completion: { (person, error) in
                if let error = error {
                    self.present(Utils.createAlert(message: error), animated: true, completion: nil)
                }else {
                    self.present(Utils.createAlert("You are on the board", message: "You are checked in"), animated: true, completion: nil)
                }
            })
        }
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

