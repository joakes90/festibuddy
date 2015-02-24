//
//  DetailViewController.swift
//  Festi Countdown
//
//  Created by Justin Oakes on 1/5/15.
//  Copyright (c) 2015 Justin Oakes. All rights reserved.
//

import UIKit
//import iAd

class DetailViewController: UIViewController {
    
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
            println("I ran")
            NSUserDefaults.standardUserDefaults().setValue(self.fest?.title, forKey: "default_fest")
        }
    
        let controller: ARAlertController = ARAlertController(title: "Options", message: nil, preferredStyle: ARAlertControllerStyle.ActionSheet)
        controller.addAction(defaultAction)
        controller.presentInViewController(self, animated: true, completion: nil)
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
