//
//  MenuTableViewController.swift
//  Festi Buddy
//
//  Created by Justin Oakes on 2/21/15.
//  Copyright (c) 2015 Oklasoft. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    let menuItems: [String] = ["", "Festival Countdown", "Festivals Map", "Make a Packing list", "Tent/Car Finder", "About/Battery Tips"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.slidingViewController().anchorRightRevealAmount = 200.0
        //self.slidingViewController().underLeftViewController.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return menuItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 

        cell.textLabel?.text = menuItems[indexPath.row]

        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let identifier = menuItems[indexPath.row]
        switch identifier{
            case "" :
                break
                       case "Festival Countdown":
                let newTopViewController: UIViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("timerNavController"))!
                self.slidingViewController().topViewController = newTopViewController
                break
            case "Festivals Map":
                let newTopViewController: UIViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("mapNavController"))!
                self.slidingViewController().topViewController = newTopViewController
                break
            case "Make a Packing list":
                let newTopViewController: UIViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("listNavController"))!
                self.slidingViewController().topViewController = newTopViewController
                break
            case "Tent/Car Finder":
                let newTopViewController: UIViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("tent"))!
                self.slidingViewController().topViewController = newTopViewController
                break
            case "About/Battery Tips":
                let newTopViewController: UIViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("about"))!
                self.slidingViewController().topViewController = newTopViewController
                break
            default :
                break
            }
       // self.slidingViewController().resetTopViewAnimated(true)
    }


}
