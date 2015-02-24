//
//  HomeViewController.swift
//  Festi Buddy
//
//  Created by Justin Oakes on 2/21/15.
//  Copyright (c) 2015 Oklasoft. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let menuButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.frame = CGRectMake(8, 25, 35, 35)
        menuButton.setImage(UIImage(named: "menubutton.png"), forState: UIControlState.Normal)
        menuButton.addTarget(self, action: "showMenu", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(menuButton)
        
        self.view.layer.shadowOpacity = 0.75
        self.view.layer.shadowRadius = 10.0
        self.view.layer.shadowColor = UIColor.blackColor().CGColor
        

        self.slidingViewController().underLeftViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Menu") as MenuTableViewController
        
        self.slidingViewController().resetTopViewAnimated(true)
        self.view.addGestureRecognizer(self.slidingViewController().panGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   @IBAction func showMenu(){
        self.slidingViewController().anchorTopViewToRightAnimated(true)
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
