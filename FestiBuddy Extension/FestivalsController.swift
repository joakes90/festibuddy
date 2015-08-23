//
//  FestivalsController.swift
//  Festi Buddy
//
//  Created by Justin Oakes on 8/22/15.
//  Copyright © 2015 Oklasoft. All rights reserved.
//

import WatchKit

class FestivalController: NSObject {
    
    static let sharedInstance = FestivalController()
    
    var festivals: [Festivals] = []
    
    
    override init() {
        super.init()
        self.festivals = []
        self.updateFestivals()
    }
    
    func updateFestivals() {
        let dateFormater: NSDateFormatter = NSDateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let path = NSBundle.mainBundle().pathForResource("festsPlist", ofType: "plist")
        let plistArray: NSArray = NSArray(contentsOfFile: path!)!
        
        // uncomment and fix this code when access to custom fests is added
        
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Festival")
        let customFests: [Festival] = try! Stack.sharedInstance().managedObjectContext.executeFetchRequest(fetchRequest) as! [Festival]
        
        self.festivals = []
        
        for fest: Festival in customFests {
            // converting date to compatable string
            let dateFormater: NSDateFormatter = NSDateFormatter()
            dateFormater.dateFormat = "yyyy-MM-dd"
            let dateString: String = dateFormater.stringFromDate(fest.date!)
            
            let convertedFest: Festivals = Festivals(title: fest.title!, date: dateString, lat: fest.latitude!, long: fest.longitude!)
            
            self.festivals.append(convertedFest)
        }
        
        
        
        for i in plistArray{
            
            let title = i["title"]
            let imageString = i["imageString"]
            let tableImageString = i["tableImageString"]
            let date = i["date"]
            let lat = i["lat"]
            let long = i["long"]
            let lineup = i["lineup"]
            
            let newFestivalObject: Festivals = Festivals(title: (title! as! NSString), date: (date! as! NSString), imageString: (imageString! as! NSString), tableImageString: (tableImageString! as! NSString), lat: (lat! as! NSNumber), long: (long! as! NSNumber), lineup: (lineup! as! NSString))
            self.festivals.append(newFestivalObject)
        }
        
    }
    
}
