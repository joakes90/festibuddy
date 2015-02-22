//
//  MenuTableViewController.swift
//  Festi Buddy
//
//  Created by Justin Oakes on 2/21/15.
//  Copyright (c) 2015 Oklasoft. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    let menuItems: [String] = ["", "Festival Countdown", "Festivals Map", "Make a Packing list", "Tent/Car Finder", "Battery Life Tips"]
    
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.text = menuItems[indexPath.row]

        return cell
    }




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
