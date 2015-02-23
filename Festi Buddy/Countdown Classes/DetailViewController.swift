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
    let setDefaultButton: UIBarButtonItem = UIBarButtonItem()

    
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
        self.setDefaultButton.title = NSUserDefaults.standardUserDefaults().valueForKey("default_fest") != nil ? "Clear Default Fest" : "Set Default Fest"
        self.setDefaultButton.style = UIBarButtonItemStyle.Plain
        self.setDefaultButton.target = self
        self.setDefaultButton.action = "setDefault"

        self.navigationItem.rightBarButtonItem = setDefaultButton
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
    
    
    func setDefault(){
        if (NSUserDefaults.standardUserDefaults().valueForKey("default_fest") != nil){
            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "default_fest")
            self.setDefaultButton.title = "Set Default Fest"
        }else{
            NSUserDefaults.standardUserDefaults().setValue(fest?.title, forKey: "default_fest")
            self.setDefaultButton.title = "Clear"
        }
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
