//
//  AboutViewController.swift
//  Festi Buddy
//
//  Created by Justin Oakes on 2/26/15.
//  Copyright (c) 2015 Oklasoft. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    var closed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer(self.slidingViewController().panGesture)
        self.slidingViewController().resetTopViewAnimated(true)
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
