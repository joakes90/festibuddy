//
//  DetailViewController.swift
//  Festi Countdown
//
//  Created by Justin Oakes on 1/5/15.
//  Copyright (c) 2015 Justin Oakes. All rights reserved.
//

import UIKit
import MapKit


class DetailViewController: UIViewController, UIAlertViewDelegate {
    
    var fest: Festivals?
    var timer: NSTimer?
    var closed: Bool = true

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet var deleteButton: UIButton!
    
    @IBOutlet weak var titleLable: UILabel!
    
    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if fest != nil {
            let imageString = fest?.detailImageString
            var image: UIImage = UIImage(named: imageString! as String)!
            imageView.image = image
            
            if fest?.title == "Hangout" {
                titleLable.textColor = UIColor.darkGrayColor()
            }
            titleLable.text = fest?.title as? String
            
            updateTime()
        
            timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        }
        self.slidingViewController().resetTopViewAnimated(true)
        self.view.addGestureRecognizer(self.slidingViewController().panGesture)
    }
    

    override func viewDidAppear(animated: Bool) {
        if self.fest?.customFest == true{
            self.deleteButton.hidden = false
        }
    }
    

    func updateTime(){
        fest?.update()
        timeLabel.text = "\(fest!.dayString)    \(fest!.hourString)    \(fest!.minuteString)"

        
    }
    
    @IBAction func arMenu(sender: AnyObject) {

    let defaultAction: UIAlertAction = UIAlertAction(title: "Set as Default", style: UIAlertActionStyle.Default) { (action) -> Void in
        NSUserDefaults.standardUserDefaults().setValue(self.fest?.title, forKey: "default_fest")
    }
    
    
        
        let navigationAction: UIAlertAction = UIAlertAction(title: "Navigate to Here", style: UIAlertActionStyle.Default) { (action) -> Void in
                        let canHandleGoogle: Bool = UIApplication.sharedApplication().canOpenURL(NSURL(string: "comgooglemaps://")!)
            
                        if canHandleGoogle{
                            self.googleMapsNavigation()
            
                        }else{
                            self.appleMapsNavigation()
                        }
        }

        
        let lineupAction: UIAlertAction = UIAlertAction(title: "View Lineup", style: UIAlertActionStyle.Default) { (alert) -> Void in
            self.performSegueWithIdentifier("showLineup", sender: self)
        }
        

        
        let cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            
        }
        
        //replacing arMenu with UIAlertController
        let alertController: UIAlertController = UIAlertController(title: "Options", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        alertController.addAction(defaultAction)
        if self.fest?.customFest == false {
            alertController.addAction(lineupAction)
        }
        alertController.addAction(navigationAction)
        alertController.addAction(cancel)
        
       self.presentViewController(alertController, animated: true) { () -> Void in
        
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0{
            googleMapsNavigation()
        } else{
            appleMapsNavigation()
        }
    }
    
    func appleMapsNavigation() {
        var latitude: CLLocationDegrees = (self.fest?.lat as! CLLocationDegrees)
        var longitude: CLLocationDegrees = (self.fest?.long as! CLLocationDegrees)
        var festLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let festPlaceMark: MKPlacemark = MKPlacemark(coordinate: festLocation, addressDictionary: nil)
        let festMapItem: MKMapItem = MKMapItem(placemark: festPlaceMark)
        
        let locations: [MKMapItem] = [MKMapItem.mapItemForCurrentLocation(), festMapItem]
        let launchItems: NSDictionary = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        MKMapItem.openMapsWithItems(locations, launchOptions: launchItems as NSDictionary as [NSObject : AnyObject])

    }
    
    func googleMapsNavigation() {
        let destiantion: String = "\(self.fest!.lat),\(self.fest!.long)"
       
        let directionsURL: NSURL = NSURL(string: "comgooglemaps://?daddr=\(destiantion)&directionsmode=driving")!
        UIApplication.sharedApplication().openURL(directionsURL)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showLineup"{
            let viewController: countdownWebView = segue.destinationViewController as! countdownWebView
            viewController.urlString = fest?.lineup as? String
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
    
    @IBAction func deleteFest(sender: AnyObject) {
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Festival")
        let cdFests: [Festival] = delegate.managedObjectContext.executeFetchRequest(fetchRequest, error: nil) as! [Festival]
        var festToDelete: Festival?
        for fest: Festival in cdFests {
            if fest.title == self.fest!.title{
                festToDelete = fest
        }
           
    }
        delegate.managedObjectContext.deleteObject(festToDelete!)
        delegate.managedObjectContext.save(nil)
        self.performSegueWithIdentifier("unwindFromDetailVC", sender: self)
    }
}
