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
import Alamofire


class MapViewController: UIViewController, CLLocationManagerDelegate{
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    
    var updateLocation = true
    var latitudeDelta = 0.0025
    var longitudeDelta = 0.0025
    
    var annotations: [MapPin] = []
    var overlay: MKOverlay?
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        print("view loaded")
        
        // Do any additional setup after loading the view.
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            self.mapView.showsUserLocation = true
            self.locationManager.startUpdatingLocation()
            
            
        }else{
            self.locationManager.requestWhenInUseAuthorization()
        }
        loadMap()
        mapView.mapType = MKMapType.hybrid
    }
    
    
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        let myArea = MKCoordinateRegionMakeWithDistance(self.locationManager.location!.coordinate, 500, 500)
        self.mapView.setRegion(myArea, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("view appeared")
        if !WebServices.shared.userAuthTokenExists() || WebServices.shared.userAuthTokenExpired(){
            performSegue(withIdentifier: "PresentLoginNoAnimation", sender: self)
            //print("I got here")
        }else{
            beginTimer()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopTimer()
    }
    
    func loadMap(){
        if let coordinate = locationManager.location?.coordinate {
            let checkIn = People(coordinate: coordinate)
            WebServices.shared.postObject(checkIn, completion: { (object, error) in
                if let error = error {
                    // self.present(Utils.createAlert(message: error), animated: true, completion: nil)
                }else{
                    // self.present(Utils.createAlert("Wonderful!", message: "You are checked in."),  animated: true, completion: nil)
                    
                }
            })
            
            
        }
        
        let peopleNearby = People(radius: 100)
        WebServices.shared.getObjects(peopleNearby){
            (nearbyPeople, error) in
            if let nearbyPeople = nearbyPeople{
                let otherAnnotations = self.annotations
                self.annotations = []
                for people in nearbyPeople {
                    let pin = MapPin(people: people)
                    //self.peopleNearby.append(pin)
                    self.annotations.append(pin)
                }
                self.mapView.addAnnotations(self.annotations)
                self.mapView.removeAnnotations(otherAnnotations)
            }
        }
    }
    
    
    func beginTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(loadMap), userInfo: nil, repeats: true)
    }
    func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    
    //Mark - @IBActions
    @IBAction func logout(_ sender: Any) {
        UserStore.shared.logout{
            self.performSegue(withIdentifier: "PresentLogin", sender: self)
        }
        
    }
    
    @IBAction func CheckIn(_ sender: AnyObject) {
        //get the location
        if let location = locationManager.location {
            
            let coordinate = location.coordinate
            
            //create user object with that location
            //  let people = People(coordinate: coordinate!)
            
            //call webservices .post with the user object
            //    WebServices.shared.postObject(people, completion: { (person, error) in
            
            
            //   })
            
            
        }
        loadMap()
        
        
    }
}
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            //look up User
            if let mapPin = annotation as? MapPin{
                if let image = Utils.stringToImage(str: mapPin.people?.avatarBase64){
                    let resizedImage = Utils.resizeImage(image: image, maxSize: 20)
                    pinView?.image = resizedImage
                    pinView?.contentMode = .scaleToFill
                    pinView?.clipsToBounds = false
                    pinView?.layer.borderWidth = 2
                    pinView?.layer.borderColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1).cgColor
                }else{
                    pinView?.image = nil
                }
                
            }
        }
        return pinView
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let mapPin = view.annotation as? MapPin, let people = mapPin.people, let name = people.userName, let userId = people.userId {
            let alert = UIAlertController(title: "Catch User", message: "Catch\(name)?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Catch", style: .default, handler: { (action) in
                let catchPeople = People(caughtUserId: userId, radiusInMeters: Int(Constants.radius))
                WebServices.shared.postObject(catchPeople, completion: { (object, error) in
                    if let error = error{
                        self.present(Utils.createAlert(message: error), animated: true, completion: nil)
                    } else{
                        self.present(Utils.createAlert("Yay!", message: "User Caught"), animated: true, completion: nil)
                    }
                })
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        self.overlay = overlay
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.green
        renderer.lineWidth = 5.0
        renderer.lineCap = CGLineCap.round
        return renderer
    }
}



//table row //endpoint for caught ,
