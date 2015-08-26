//
//  TableInterfaceController.swift
//  Festi Buddy
//
//  Created by Justin Oakes on 8/24/15.
//  Copyright © 2015 Oklasoft. All rights reserved.
//

import WatchKit
import Foundation


class TableInterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    
    let delegate: ExtensionDelegate = WKExtension.sharedExtension().delegate as! ExtensionDelegate
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        super.willActivate()
        
        self.table.setNumberOfRows(ItemsController.sharedInstance.items.count, withRowType: "wkRow")
        
        for var row: Int = 0; row < ItemsController.sharedInstance.items.count; row++ {
            let rowController: RowController = self.table.rowControllerAtIndex(row) as! RowController
            rowController.itemLabel.setText(ItemsController.sharedInstance.items[row].name!)
            
            if ItemsController.sharedInstance.items[row].have!.boolValue {
                rowController.itemImage.setImageNamed("checked")
            } else {
                rowController.itemImage.setImageNamed("unchecked")
            }
            
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        let selectedRow: RowController = self.table.rowControllerAtIndex(rowIndex) as! RowController
        selectedRow.itemImage.setImageNamed("checked")
        ItemsController.sharedInstance.items[rowIndex].have = true
        do {
            try Stack.sharedInstance().managedObjectContext.save()
        }catch {
            print(error)
        }
        let dictionary: [String: AnyObject] = ["haveItem": ItemsController.sharedInstance.items[rowIndex].name!]
        delegate.updateWatchUserDefaultsWith(dictionary)
    }

}
