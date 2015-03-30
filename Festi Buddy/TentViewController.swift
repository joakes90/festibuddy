//
//  TentViewController.swift
//  Festi Buddy
//
//  Created by Justin Oakes on 2/26/15.
//  Copyright (c) 2015 Oklasoft. All rights reserved.
//

import UIKit
import MapKit

class TentViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapview: MKMapView!
    var closed: Bool = true
    let locationManager: CLLocationManager = CLLocationManager()
    var locationUpdate: NSTimer?
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.requestWhenInUseAuthorization()
        self.mapview.setUserTrackingMode(MKUserTrackingMode.FollowWithHeading, animated: true)
        
        if NSUserDefaults.standardUserDefaults().valueForKey("tentLat") == nil && NSUserDefaults.standardUserDefaults().valueForKey("tentLong") == nil{
            button.setTitle("Mark This Spot", forState: UIControlState.Normal)
        } else {
            button.setTitle("Clear This Spot", forState: UIControlState.Normal)
            let marker: MKPointAnnotation = MKPointAnnotation()
            let latitude: Double = NSUserDefaults.standardUserDefaults().doubleForKey("tentLat")
            let longitude: Double = NSUserDefaults.standardUserDefaults().doubleForKey("tentLong")
            let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
            marker.coordinate = location
            marker.title = "My Spot"
            mapview.addAnnotation(marker)

        }
      //  locationUpdate = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "setRegion", userInfo: nil, repeats: true)
        
        self.slidingViewController().resetTopViewAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let marker: MKPointAnnotation = MKPointAnnotation()
        if NSUserDefaults.standardUserDefaults().valueForKey("tentLat") == nil && NSUserDefaults.standardUserDefaults().valueForKey("tentLong") == nil{
            let latitude: Double = mapview.userLocation.coordinate.latitude as Double
            let longitude: Double = mapview.userLocation.coordinate.longitude as Double
            NSUserDefaults.standardUserDefaults().setDouble(latitude, forKey: "tentLat")
            NSUserDefaults.standardUserDefaults().setDouble(longitude, forKey: "tentLong")
            let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
            marker.coordinate = location
            marker.title = "My Spot"
            mapview.addAnnotation(marker)
            button.setTitle("Clear This Spot", forState: UIControlState.Normal)
        }else{
            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "tentLat")
            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "tentLong")
            button.setTitle("Mark This Spot", forState: UIControlState.Normal)
            mapview.removeAnnotations(mapview.annotations)
        }
    }
    
    func setRegion(){
        if NSUserDefaults.standardUserDefaults().valueForKey("tentLat") as Double? == nil && mapview.userLocation.coordinate.latitude != 0.0{
            var location:CLLocationCoordinate2D = self.mapview.userLocation.coordinate
            let theSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            var theRegon: MKCoordinateRegion = MKCoordinateRegion(center: location, span: theSpan)
            mapview.region = theRegon
        }else if mapview.userLocation.coordinate.latitude != 0.0{
            var latDelta: CLLocationDegrees = (NSUserDefaults.standardUserDefaults().valueForKey("tentLat") as Double - mapview.userLocation.coordinate.latitude as Double) 
            var longDelta:CLLocationDegrees = (NSUserDefaults.standardUserDefaults().valueForKey("tentLong") as Double - mapview.userLocation.coordinate.longitude as Double)
            
            if latDelta < 0 { latDelta = latDelta * -1}
            if longDelta < 0 { longDelta = longDelta * -1}
            
            let theSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
            let theRegion: MKCoordinateRegion = MKCoordinateRegion(center: mapview.userLocation.coordinate, span: theSpan)
            
            mapview.region = theRegion
        }else{
            locationUpdate?.invalidate()
        }
    }
}
