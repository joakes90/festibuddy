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
