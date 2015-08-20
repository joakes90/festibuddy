//
//  ItemsController.swift
//  Festi Buddy
//
//  Created by Justin Oakes on 8/19/15.
//  Copyright © 2015 Oklasoft. All rights reserved.
//

import UIKit

class ItemsController: NSObject {
    
    static let sharedInstance = ItemsController()
    
    var items: [Items] = []
    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override init() {
        super.init()
        self.items = []
        self.updateItems()
    }
    
    func updateItems() {
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Items")
        do {
            self.items = try delegate.managedObjectContext.executeFetchRequest(fetchRequest) as! [Items]
        } catch {
            print("failed to get items from coredata")
        }
    }
    
    func checkForDuplicate(name: String)->Bool {
        var duplicate: Bool = false
        self.updateItems()
        for item: Items in self.items {
            if name == item.name{
                duplicate = true
            }
        }
        return duplicate
    }
}
