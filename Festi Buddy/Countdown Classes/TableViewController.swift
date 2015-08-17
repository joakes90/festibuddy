//
//  TableViewController.swift
//  Festi Countdown
//
//  Created by Justin Oakes on 1/4/15.
//  Copyright (c) 2015 Justin Oakes. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var destinationFest: Festivals?
    var initialRun: Bool = true
    var menubutton:UIBarButtonItem = UIBarButtonItem()
    var closed: Bool = true
    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.menubutton.title = "Menu"
        self.menubutton.style = UIBarButtonItemStyle.Plain
        self.menubutton.target = self
        self.menubutton.action = "showMenu"
        self.navigationItem.leftBarButtonItem = menubutton
        
                if (NSUserDefaults.standardUserDefaults().valueForKey("default_fest") != nil){
            let festivalName: String = NSUserDefaults.standardUserDefaults().valueForKey("default_fest") as! String
            for i in FestivalController.sharedInstance.festivals {
                if i.title == festivalName{
                    destinationFest = i
                }
            }
            
            self.performSegueWithIdentifier("seeTheCountdown", sender: self)
        }
        initialRun = false
        self.slidingViewController().resetTopViewAnimated(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        FestivalController.sharedInstance.updateFestivals()
        self.tableView.reloadData()
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
        return FestivalController.sharedInstance.festivals.count + 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cellID = "cell"
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellID) as! UITableViewCell
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "+ Add new Festival"
            cell.imageView?.image = nil
            return cell
        }
        var title = FestivalController.sharedInstance.festivals[indexPath.row - 1].title
        var image = FestivalController.sharedInstance.festivals[indexPath.row - 1].tableImage
        cell.textLabel?.text = title as String
        cell.imageView?.image = UIImage(named: image)

        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.indexPathForSelectedRow()?.row == 0 {
            self.performSegueWithIdentifier("addFest", sender: self)
        } else {
            self.performSegueWithIdentifier("seeTheCountdown", sender: self)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "seeTheCountdown" {
            if !initialRun && tableView.indexPathForSelectedRow()?.row != 0 {
                var index = tableView.indexPathForSelectedRow()?.row
                let viewController = segue.destinationViewController as! DetailViewController
                let fest: Festivals = FestivalController.sharedInstance.festivals[index! - 1]
            
                viewController.fest = fest
            }else{
                let viewController = segue.destinationViewController as! DetailViewController
                
                viewController.fest = destinationFest

            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.slidingViewController().underLeftViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Menu") as! UIViewController

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
    
    //adding unwind function
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
}
