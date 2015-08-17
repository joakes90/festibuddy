//
//  Festivals.swift
//  Festi Countdown
//
//  Created by Justin Oakes on 1/4/15.
//  Copyright (c) 2015 Justin Oakes. All rights reserved.
//

import Foundation

class Festivals {
    let date: NSDate?
    let title: NSString
    let detailImageString: NSString
    let tableImage: String
    let gregorianCalendar = NSCalendar(identifier: NSGregorianCalendar)
    let customFest: Bool
    var days: Int = 0
    var hours: Int = 0
    var minutes: Int = 0
    
    var dayString: String = ""
    var hourString: String = ""
    var minuteString: String = ""
    
    var lat: NSNumber = 0
    var long: NSNumber = 0
    
    var lineup: NSString
    var timer: NSTimer?
    
    
    
    
    
    func timeTillFest()->NSDateComponents  {
        let timeZone = NSTimeZone.localTimeZone()
        let interval = timeZone.secondsFromGMT
        let currentDate = NSDate().dateByAddingTimeInterval(NSTimeInterval(interval))
        let toDate = self.date!.dateByAddingTimeInterval(NSTimeInterval(interval))
        let componets: NSCalendarUnit = [.NSDayCalendarUnit, .NSHourCalendarUnit, .NSMinuteCalendarUnit]
        
        let currentComponets = gregorianCalendar?.components(componets, fromDate: currentDate, toDate: toDate, options: [])
        
        return currentComponets!
    }
    
   
    
    
    
    func update(){
        let componets = timeTillFest()
        
        self.days = componets.day
        self.hours = componets.hour
        self.minutes = componets.minute
        
        if Int(self.days) <= 0 && Int(self.hours) <= 0 && Int(self.minutes) <= 0 {
            self.dayString = "0"
            self.hourString = "0"
            self.minuteString = "0"
            
        } else {
            self.dayString = String(self.days)
            self.hourString = String(self.hours)
            self.minuteString = String(self.minutes)
        }

    }
    
    init(title: NSString?, date: NSString?, imageString: NSString?, tableImageString: NSString?, lat: NSNumber, long: NSNumber, lineup: NSString){
        
        let dateFormater: NSDateFormatter = NSDateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        
        self.title = title!
        self.date = dateFormater.dateFromString(date! as String)
        self.detailImageString = imageString!
        self.tableImage = tableImageString! as String
        self.lineup = lineup
        self.customFest = false
        
       let componets = timeTillFest()
        
        self.days = componets.day
        self.hours = componets.hour
        self.minutes = componets.minute
        
        self.dayString = String(self.days)
        self.hourString = String(self.hours)
        self.minuteString = String(self.minutes)
        
        self.lat = lat
        self.long = long
    }
    
    init(title: NSString, date: NSString?, lat: NSNumber, long: NSNumber){
        let dateFormater: NSDateFormatter = NSDateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        
        self.title = title
        self.date = dateFormater.dateFromString(date as! String)
        self.lat = lat
        self.long = long
        self.customFest = true
        
        self.tableImage = "defaultTable.png"
        self.detailImageString = "default.png"
        self.lineup = ""
        
    }
}

