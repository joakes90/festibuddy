//
//  MapView.swift
//  Festi Buddy
//
//  Created by Justin Oakes on 2/24/15.
//  Copyright (c) 2015 Oklasoft. All rights reserved.
//

import UIKit
import GoogleMaps

class MapView: UIViewController {
    
    var closed: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let camera = GMSCameraPosition.cameraWithLatitude(39.8282, longitude: -95.9095, zoom: 3.2)
        let mapview = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        self.view = mapview
        self.slidingViewController().resetTopViewAnimated(true)
        self.view.addGestureRecognizer(self.slidingViewController().panGesture)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        FestivalController.sharedInstance.updateFestivals()
        
        for fest: Festivals in FestivalController.sharedInstance.festivals {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(fest.lat.doubleValue, fest.long.doubleValue)
            marker.appearAnimation = kGMSMarkerAnimationPop
            if fest.days <= 0 && fest.hours <= 0{
                                marker.snippet = "\(fest.title) is over"
                            } else {
                                marker.snippet = "\(fest.title) happening in \(fest.dayString) days"
                            }

            marker.map = self.view as? GMSMapView
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
    
}
