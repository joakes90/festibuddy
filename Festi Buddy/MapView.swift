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
    
    let latDelta: CLLocationDegrees = 0.10
    let longDelta: CLLocationDegrees = 0.10
    
    var festivalLocations: [CLLocationCoordinate2D] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            
            var newFestivalObject: Festivals = Festivals(title: (title! as NSString), date: (date! as NSString), imageString: (imageString! as NSString), tableImageString: (tableImageString! as NSString), lat: (lat! as NSNumber), long: (long! as NSNumber), lineup: (lineup! as NSString))
            
            var latitude: CLLocationDegrees = newFestivalObject.lat as CLLocationDegrees
            var longitude: CLLocationDegrees = newFestivalObject.long as CLLocationDegrees
            
            let theSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
            
            var festLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
             var newAnnotation = MKPointAnnotation()
            newAnnotation.coordinate = festLocation
            newAnnotation.title = newFestivalObject.title
            newAnnotation.subtitle = "Happening in \(newFestivalObject.dayString) days"
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

}
