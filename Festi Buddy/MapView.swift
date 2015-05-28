//
//  MapView.swift
//  Festi Buddy
//
//  Created by Justin Oakes on 2/24/15.
//  Copyright (c) 2015 Oklasoft. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var closed: Bool = true
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    let latDelta: CLLocationDegrees = 10.5
    let longDelta: CLLocationDegrees = 10.5
    
    var festivalLocations: [CLLocationCoordinate2D] = []
    
    var locationUpdate: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true

        
        locationUpdate = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "setRegion", userInfo: nil, repeats: true)
        
        let path = NSBundle.mainBundle().pathForResource("festsPlist", ofType: "plist")
        let plistArray: NSArray = NSArray(contentsOfFile: path!)!
        
        for i in plistArray {
            
            var title = i["title"]
            var imageString = i["imageString"]
            var tableImageString = i["tableImageString"]
            var date = i["date"]
            var lat = i["lat"]
            var long = i["long"]
            var lineup = i["lineup"]
            
            var newFestivalObject: Festivals = Festivals(title: (title! as! NSString), date: (date! as! NSString), imageString: (imageString! as! NSString), tableImageString: (tableImageString! as! NSString), lat: (lat! as! NSNumber), long: (long! as! NSNumber), lineup: (lineup! as! NSString))
            
            var latitude: CLLocationDegrees = newFestivalObject.lat as CLLocationDegrees
            var longitude: CLLocationDegrees = newFestivalObject.long as CLLocationDegrees
            
            var festLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
             var newAnnotation = MKPointAnnotation()
            newAnnotation.coordinate = festLocation
            newAnnotation.title = newFestivalObject.title as String
            
            if newFestivalObject.days <= 0 && newFestivalObject.hours <= 0{
                newAnnotation.subtitle = "Happening in 0 days"
            } else {
                newAnnotation.subtitle = "Happening in \(newFestivalObject.dayString) days"
            }
            mapView.addAnnotation(newAnnotation)
            
        }
        self.slidingViewController().resetTopViewAnimated(true)
        self.view.addGestureRecognizer(self.slidingViewController().panGesture)
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
    
    func setRegion(){
        if self.mapView.userLocation.coordinate.latitude == 0.0 {
            var location:CLLocationCoordinate2D = self.mapView.userLocation.coordinate
            let theSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
            var theRegon: MKCoordinateRegion = MKCoordinateRegion(center: location, span: theSpan)
            mapView.region = theRegon
        }else{
            locationUpdate?.invalidate()
        }
    }

}
