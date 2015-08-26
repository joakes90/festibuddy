//
//  MapInterfaceController.swift
//  Festi Buddy
//
//  Created by Justin Oakes on 8/25/15.
//  Copyright © 2015 Oklasoft. All rights reserved.
//

import WatchKit
import Foundation


class MapInterfaceController: WKInterfaceController {

    @IBOutlet var map: WKInterfaceMap!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let lat: Double = NSUserDefaults.standardUserDefaults().doubleForKey("tentLat")
        let long: Double = NSUserDefaults.standardUserDefaults().doubleForKey("tentLong")
        
        if lat != 0.0 && long != 0.0 {
            let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            
            self.map.setRegion(region)
            
            //add anotation here later
            self.map.addAnnotation(location, withPinColor: WKInterfaceMapPinColor.Purple)
            
        } else {
            let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 35.4822, longitude: -97.5350)
            let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
            self.map.setRegion(region)
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
