//
//  TableViewController.swift
//  Festi Countdown
//
//  Created by Justin Oakes on 1/4/15.
//  Copyright (c) 2015 Justin Oakes. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var festivals: [Festivals] = []
    var destinationFest: Festivals?
    var initialRun: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let dateFormater: NSDateFormatter = NSDateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let path = NSBundle.mainBundle().pathForResource("festsPlist", ofType: "plist")
        let plistArray: NSArray = NSArray(contentsOfFile: path!)!
        
        for i in plistArray{
            
            var title = i["title"]
            var imageString = i["imageString"]
            var tableImageString = i["tableImageString"]
            var date = i["date"]
            var lat = i["lat"]
            var long = i["long"]
            var lineup = i["lineup"]
            
            var newFestivalObject: Festivals = Festivals(title: (title! as NSString), date: (date! as NSString), imageString: (imageString! as NSString), tableImageString: (tableImageString! as NSString), lat: (lat! as NSNumber), long: (long! as NSNumber), lineup: (lineup! as NSString))
            festivals.append(newFestivalObject)
        }
        if (NSUserDefaults.standardUserDefaults().valueForKey("default_fest") != nil){
            let festivalName: String = NSUserDefaults.standardUserDefaults().valueForKey("default_fest") as String
            for i in festivals{
                if i.title == festivalName{
                    destinationFest = i
                }
            }
            
            self.performSegueWithIdentifier("seeTheCountdown", sender: self)
        }
        initialRun = false
        self.slidingViewController().resetTopViewAnimated(true)
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
        return festivals.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cellID = "cell"
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellID) as UITableViewCell
        var title = festivals[indexPath.row].title
        var image = festivals[indexPath.row].tableImage
        cell.textLabel?.text = title
        cell.imageView?.image = UIImage(named: image)

        return cell
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "seeTheCountdown" {
            if !initialRun {
                var index = tableView.indexPathForSelectedRow()?.row
                let viewController = segue.destinationViewController as DetailViewController
                let fest: Festivals = festivals[index!]
            
                viewController.fest = fest
            }else{
                let viewController = segue.destinationViewController as DetailViewController
                
                viewController.fest = destinationFest

            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if !self.slidingViewController().underLeftViewController.isKindOfClass(MenuTableViewController){
            self.slidingViewController().underLeftViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Menu") as UIViewController
        }
    }

}
