//
//  countdownWebView.swift
//  Festi Buddy
//
//  Created by Justin Oakes on 2/24/15.
//  Copyright (c) 2015 Oklasoft. All rights reserved.
//

import UIKit

class countdownWebView: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlRequest: NSURLRequest = NSURLRequest(URL: NSURL(string: self.urlString!)!)
        webView.loadRequest(urlRequest)
        
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

}
