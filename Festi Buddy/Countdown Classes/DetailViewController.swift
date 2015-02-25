//
//  DetailViewController.swift
//  Festi Countdown
//
//  Created by Justin Oakes on 1/5/15.
//  Copyright (c) 2015 Justin Oakes. All rights reserved.
//

import UIKit
import MapKit
//import iAd

class DetailViewController: UIViewController, UIAlertViewDelegate {
    
    var fest: Festivals?
    var timer: NSTimer?

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!

   // @IBOutlet weak var adBanner: ADBannerView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  /*
        self.canDisplayBannerAds = true
        self.adBanner.delegate = self
        self.adBanner.hidden = true
    */
       
        
        if fest != nil {
            let imageString = fest?.detailImageString
            var image: UIImage = UIImage(named: imageString!)!
            imageView.image = image
            titleLable.text = fest?.title
            
            updateTime()
        
            timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        }
        self.slidingViewController().resetTopViewAnimated(true)
        self.view.addGestureRecognizer(self.slidingViewController().panGesture)
    }
    
   /* func bannerViewDidLoadAd(banner: ADBannerView!) {
        adBanner.hidden = false
    }
   
    //shot probably do somthing with this method later, Xcode seems to throw a hissy fit when it is not there.
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {

    }*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func updateTime(){
        fest?.update()
        timeLabel.text = "\(fest!.dayString)    \(fest!.hourString)    \(fest!.minuteString)"

        
    }
    
    @IBAction func arMenu(sender: AnyObject) {
        let defaultAction: ARAlertAction = ARAlertAction(title: "Set as Default Festival", style: ARAlertActionStyle.Default) { (setDefault) -> Void in
            NSUserDefaults.standardUserDefaults().setValue(self.fest?.title, forKey: "default_fest")
        }
        let navigateAction: ARAlertAction = ARAlertAction(title: "Navigate to Here", style: ARAlertActionStyle.Default) { (navigate) -> Void in
            let canHandleGoogle: Bool = UIApplication.sharedApplication().canOpenURL(NSURL(string: "comgooglemaps://")!)
            
            if canHandleGoogle{
                let alert: UIAlertView = UIAlertView(title: "Select Map", message: "Would you like to use Google or Apple Maps", delegate: self, cancelButtonTitle: nil)
                alert.addButtonWithTitle("Google Maps")
                alert.addButtonWithTitle("Apple Maps")
                alert.tag = 100
                alert.show()
                
            }else{
                self.appleMapsNavigation()
            }
        }
        
        let lineupAction: ARAlertAction = ARAlertAction(title: "View Lineup", style: ARAlertActionStyle.Default) { (lineUp) -> Void in
            self.performSegueWithIdentifier("showLineup", sender: self)
            
        }
        
        let cancel: ARAlertAction = ARAlertAction(title: "Cancel", style: ARAlertActionStyle.Cancel) { (cancel) -> Void in
            
        }
        
        let controller: ARAlertController = ARAlertController(title: "Options", message: nil, preferredStyle: ARAlertControllerStyle.ActionSheet)
        controller.addAction(defaultAction)
        controller.addAction(lineupAction)
        controller.addAction(navigateAction)
        controller.addAction(cancel)
        
        controller.presentInViewController(self, animated: true, completion: nil)
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0{
            googleMapsNavigation()
        } else{
            appleMapsNavigation()
        }
    }
    
    func appleMapsNavigation() {
        var latitude: CLLocationDegrees = (self.fest?.lat as CLLocationDegrees)
        var longitude: CLLocationDegrees = (self.fest?.long as CLLocationDegrees)
        var festLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let festPlaceMark: MKPlacemark = MKPlacemark(coordinate: festLocation, addressDictionary: nil)
        let festMapItem: MKMapItem = MKMapItem(placemark: festPlaceMark)
        
        let locations: [MKMapItem] = [MKMapItem.mapItemForCurrentLocation(), festMapItem]
        let launchItems: NSDictionary = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        MKMapItem.openMapsWithItems(locations, launchOptions: launchItems as NSDictionary)

    }
    
    func googleMapsNavigation() {
        let destiantion: String = "\(self.fest?.lat)+\(self.fest?.long)"
       
        let directionsURL: NSURL = NSURL(string: "comgooglemaps://maps.google.com/maps?z=3&t=m&q=loc:\(destiantion)")!
        UIApplication.sharedApplication().openURL(directionsURL)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showLineup"{
            let viewController: countdownWebView = segue.destinationViewController as countdownWebView
            viewController.urlString = fest?.lineup
        }
    }
    
    @IBAction func showMenu(){
        self.slidingViewController().anchorTopViewToRightAnimated(true)
    }

}
