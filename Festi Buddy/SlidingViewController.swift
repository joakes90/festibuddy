//
//  SlidingViewController.swift
//  Festi Buddy
//
//  Created by Justin Oakes on 2/21/15.
//  Copyright (c) 2015 Oklasoft. All rights reserved.
//

import UIKit


class SlidingViewController: ECSlidingViewController {

    override func viewDidLoad() {
        
        self.topViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Main") as! HomeViewController
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
