//
//  CountdownInterfaceController.swift
//  Festi Buddy
//
//  Created by Justin Oakes on 8/21/15.
//  Copyright © 2015 Oklasoft. All rights reserved.
//

import WatchKit
import Foundation


class CountdownInterfaceController: WKInterfaceController {

    @IBOutlet var festPicker: WKInterfacePicker!
    @IBOutlet var infoLabel: WKInterfaceLabel!
    var indexOfVisableFest: Int = 0
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        super.willActivate()
        var pickerItems: [WKPickerItem] = []
        for fest: Festivals in FestivalController.sharedInstance.festivals {
            let pickerItem: WKPickerItem = WKPickerItem()
            pickerItem.title = fest.title as String
            pickerItem.contentImage = WKImage(imageName: fest.detailImageString as String)
            pickerItems.append(pickerItem)
        }
        self.festPicker.setItems(pickerItems)
        if FestivalController.sharedInstance.festivals[0].days <= 0{
            self.infoLabel.setText("\(FestivalController.sharedInstance.festivals[0].title) is over")
        } else {
            self.infoLabel.setText("\(FestivalController.sharedInstance.festivals[0].title) happening in \(FestivalController.sharedInstance.festivals[0].days + 1)")
        }
        
        if NSUserDefaults.standardUserDefaults().stringForKey("default_fest") != nil {
            let index: Int = self.findIndexForFestNamed(NSUserDefaults.standardUserDefaults().stringForKey("default_fest")!)
            self.festPicker.setSelectedItemIndex(index)
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func pickerSelectedItemHasChanged(value: Int) {
        self.indexOfVisableFest = value
        
        let newText: String = FestivalController.sharedInstance.festivals[value].title as String
        let days = FestivalController.sharedInstance.festivals[value].days + 1
        if days <= 0 {
            self.infoLabel.setText("\(newText) is over")
        } else {
            self.infoLabel.setText("\(newText) happening in \(days) days")
        }
    }
    @IBAction func setDefaultFest() {
        NSUserDefaults.standardUserDefaults().setValue(FestivalController.sharedInstance.festivals[self.indexOfVisableFest].title, forKey: "default_fest")
    }
    
    func findIndexForFestNamed(title: String)-> Int {
        var index: Int = 0
        var iteration: Int = 0
        
        for fest: Festivals in FestivalController.sharedInstance.festivals {
            if fest.title == title {
                index = iteration
            }
            iteration += 1
        }
        return index
    }
}
