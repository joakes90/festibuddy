//
//  TentViewController.swift
//  Festi Buddy
//
//  Created by Justin Oakes on 2/26/15.
//  Copyright (c) 2015 Oklasoft. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class TentViewController: UIViewController, CLLocationManagerDelegate {

    var closed: Bool = true
    let locationManager: CLLocationManager = CLLocationManager()
    var mapView: GMSMapView?
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.headingFilter = 45
        self.locationManager.startUpdatingLocation()
        self.locationManager.startUpdatingHeading()
        if self.locationManager.location != nil {
            let camera = GMSCameraPosition.cameraWithLatitude((self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!, zoom: Float(16.5))
            self.mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
            self.view = self.mapView
            self.mapView!.animateToBearing((self.locationManager.location?.course)!)
        }
//        self.mapview.setUserTrackingMode(MKUserTrackingMode.FollowWithHeading, animated: true)
        
        // look for a way to track location on a google map smialer to this
        
//        if NSUserDefaults.standardUserDefaults().valueForKey("tentLat") == nil && NSUserDefaults.standardUserDefaults().valueForKey("tentLong") == nil{
//            button.setTitle("Mark This Spot", forState: UIControlState.Normal)
//        } else {
//            button.setTitle("Clear This Spot", forState: UIControlState.Normal)
        
        //use this a refrence for the google maps pointer
            
//            let marker: MKPointAnnotation = MKPointAnnotation()
//            let latitude: Double = NSUserDefaults.standardUserDefaults().doubleForKey("tentLat")
//            let longitude: Double = NSUserDefaults.standardUserDefaults().doubleForKey("tentLong")
//            let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
//            marker.coordinate = location
//            marker.title = "My Spot"
//            mapview.addAnnotation(marker)

//        }
      //  locationUpdate = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "setRegion", userInfo: nil, repeats: true)
        
        self.slidingViewController().resetTopViewAnimated(true)
    }

    
    @IBAction func showMenu(){
        if self.closed {
            self.slidingViewController().anchorTopViewToRightAnimated(true)
            self.closed = false
        } else{
            self.slidingViewController().resetTopViewAnimated(true)
            self.closed = true
        }

    }
    
    @IBAction func markLocation(sender: AnyObject) {
        //find google maps code to place a marker like this
        
//        let marker: MKPointAnnotation = MKPointAnnotation()
//        if NSUserDefaults.standardUserDefaults().valueForKey("tentLat") == nil && NSUserDefaults.standardUserDefaults().valueForKey("tentLong") == nil{
//            let latitude: Double = mapview.userLocation.coordinate.latitude as Double
//            let longitude: Double = mapview.userLocation.coordinate.longitude as Double
//            NSUserDefaults.standardUserDefaults().setDouble(latitude, forKey: "tentLat")
//            NSUserDefaults.standardUserDefaults().setDouble(longitude, forKey: "tentLong")
//            let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
//            marker.coordinate = location
//            marker.title = "My Spot"
//            mapview.addAnnotation(marker)
//            button.setTitle("Clear This Spot", forState: UIControlState.Normal)
//        }else{
//            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "tentLat")
//            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "tentLong")
//            button.setTitle("Mark This Spot", forState: UIControlState.Normal)
//            mapview.removeAnnotations(mapview.annotations)
//        }
    }
    
    
    //MARK: CLLocationManagerDelegate methods
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        //set the map view here later
    }
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.mapView?.animateToBearing((self.locationManager.location?.course)!)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
}
