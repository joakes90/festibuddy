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
    
    override init() {
        super.init()
        self.items = []
        self.updateItems()
    }
    
    func updateItems() {
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Items")
        do {
            self.items = try Stack.sharedInstance().managedObjectContext.executeFetchRequest(fetchRequest) as! [Items]
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
    
    func findIndexFor(name: String)-> Int {
        self.updateItems()
        var index: Int? = nil
        for var i: Int = 0; i < items.count; i++ {
            if items[i].name == name{
                index = i
            }
        }
        return index!
    }
}
