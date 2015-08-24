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
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        //
    }

}
