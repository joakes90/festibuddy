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
    var tentMarker: GMSMarker?
    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.headingFilter = 45
        self.locationManager.distanceFilter = 5
        self.locationManager.startUpdatingLocation()
        self.locationManager.startUpdatingHeading()
        self.slidingViewController().resetTopViewAnimated(true)
    }

    override func viewDidAppear(animated: Bool) {
        if self.locationManager.location != nil {
            let camera = GMSCameraPosition.cameraWithLatitude((self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!, zoom: Float(16.5))
            self.mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
            self.view = self.mapView
            self.mapView?.myLocationEnabled = true
            self.mapView!.animateToBearing((self.locationManager.location?.course)!)
            
        } else {
            let camera = GMSCameraPosition.cameraWithLatitude(39.8282, longitude: -95.9095, zoom: 3.2)
            self.mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
            self.view = self.mapView
        }
        
        if NSUserDefaults.standardUserDefaults().doubleForKey("tentLat") != 0.0 && NSUserDefaults.standardUserDefaults().doubleForKey("tentLong") != 0.0 {
            let latitude: Double = NSUserDefaults.standardUserDefaults().doubleForKey("tentLat")
            let longitude: Double = NSUserDefaults.standardUserDefaults().doubleForKey("tentLong")
            let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
            let marker: GMSMarker = GMSMarker(position: location)
            marker.map = self.mapView
            
        } else {
            self.tentMarker?.map = nil
        }

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
        
        if NSUserDefaults.standardUserDefaults().doubleForKey("tentLat") == 0.0 && NSUserDefaults.standardUserDefaults().doubleForKey("tentLong") == 0.0 && self.locationManager.location != nil{
            let latitude: CLLocationDegrees = (self.locationManager.location?.coordinate.latitude)!
            let longitude: CLLocationDegrees = (self.locationManager.location?.coordinate.longitude)!
            NSUserDefaults.standardUserDefaults().setDouble(Double(latitude), forKey: "tentLat")
            NSUserDefaults.standardUserDefaults().setDouble(Double(longitude), forKey: "tentLong")
            let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            self.tentMarker = GMSMarker(position: location)
            self.tentMarker!.appearAnimation = kGMSMarkerAnimationPop
            self.tentMarker?.map = self.mapView
            
            // sending location to watch
            let dictionary: [String: AnyObject] = ["tentLat": Double(latitude), "tentLong": Double(longitude)]
            self.delegate.updateWatchUserDefaultsWithDictionary(dictionary)
            
        }else{
            self.tentMarker?.map = nil
            NSUserDefaults.standardUserDefaults().setDouble(0.0, forKey: "tentLat")
            NSUserDefaults.standardUserDefaults().setDouble(0.0, forKey: "tentLong")
            self.mapView?.clear()
            //clear location from apple watch
            let dictionary: [String: AnyObject] = ["tentLat": Double(0.0), "tentLong": Double(0.0)]
            delegate.updateWatchUserDefaultsWithDictionary(dictionary)
        }
    }
    
    
    //MARK: CLLocationManagerDelegate methods
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if self.locationManager.location != nil {
            self.mapView?.animateToZoom(Float(16.5))
            self.mapView?.animateToLocation((self.locationManager.location?.coordinate)!)
            self.mapView?.animateToBearing((self.locationManager.location?.course)!)
            

        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if self.locationManager.location != nil {
            self.mapView?.animateToBearing((self.locationManager.location?.course)!)
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if self.locationManager.location != nil {
            self.mapView?.animateToLocation((self.locationManager.location?.coordinate)!)
        }
    }
    
}
