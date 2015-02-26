//
//  AddItemsTableViewController.swift
//  Festi Countdown
//
//  Created by Justin Oakes on 1/31/15.
//  Copyright (c) 2015 Justin Oakes. All rights reserved.
//

import UIKit
import CoreData

class AddItems: UITableViewController, NSFetchedResultsControllerDelegate {

    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var context: NSManagedObjectContext?
    var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()

    var tableItems: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.context = delegate.managedObjectContext
        
        let itemsPath = NSBundle.mainBundle().pathForResource("packinglist", ofType: "plist")
        tableItems = NSArray(contentsOfFile: itemsPath!)!
        
        fetchedResultsController = getFetchedResultController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be  =
        
        
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
        return tableItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellID = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as UITableViewCell
        var title = tableItems[indexPath.row] as String
        var plusImage: UIImage = UIImage(named: "plusbutton.png")!
        var minusImage: UIImage = UIImage(named: "minusbutton.png")!
        
        var request = NSFetchRequest(entityName: "Items")
        request.returnsObjectsAsFaults = false
        
        var results: NSArray = (context!.executeFetchRequest(request, error: nil))!
        
        cell.imageView?.image = plusImage
        cell.textLabel?.text = title
        for i in results{
            if i.name == title{
                cell.imageView?.image = minusImage
                cell.textLabel?.text = title
            }
        }
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellID = "Cell"
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as UITableViewCell
        var plusImage: UIImage = UIImage(named: "plusbutton.png")!
        var minusImage: UIImage = UIImage(named: "minusbutton.png")!
        var title = tableItems[indexPath.row] as String
        var alreadyInList: Bool = false
        
        var request = NSFetchRequest(entityName: "Items")
        request.returnsObjectsAsFaults = false
       
        var results: NSArray = (context!.executeFetchRequest(request, error: nil))!
        
        for i in results{
            if i.name == tableItems[indexPath.row] as NSString{
                alreadyInList = true
                cell.imageView?.image = minusImage
                cell.textLabel?.text = title
                cell.selected = false
            }
            
        }
        
            cell.imageView?.image = minusImage
            cell.textLabel?.text = title
            cell.selected = false
            
        if !alreadyInList{
            addItems(tableItems[indexPath.row] as String)
            cell.imageView?.image = minusImage
            cell.selected = false
        }else{
            var managedObject: NSManagedObject?
            for i in results{
                if i.name == title{
                    managedObject = i as? NSManagedObject
                }
            }
            
            cell.imageView?.image = plusImage
            cell.textLabel?.text = title
            cell.selected = false
            context!.deleteObject(managedObject!)
            context!.save(nil)
        }

    }

    func addItems(name: NSString){
        let entityDescription = NSEntityDescription.entityForName("Items", inManagedObjectContext: context!)
        let item = Items(entity: entityDescription!, insertIntoManagedObjectContext: context) as Items
        item.have = 0
        item.name = name
        context!.save(nil)
    
    }
    
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: itemFetchRequest(), managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }

    func itemFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Items")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
}
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
}