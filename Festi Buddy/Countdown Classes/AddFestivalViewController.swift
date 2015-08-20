//
//  AddFestivalViewController.swift
//  Festi Buddy
//
//  Created by Justin Oakes on 8/15/15.
//  Copyright (c) 2015 Oklasoft. All rights reserved.
//

import UIKit
import CoreLocation


class AddFestivalViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    var festival: Festival?
    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleTextField.delegate = self
        self.locationTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: text field delegate methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if self.titleTextField.isFirstResponder() {
            self.locationTextField.becomeFirstResponder()
        } else if self.locationTextField.isFirstResponder() {
            self.locationTextField.resignFirstResponder()
        }
        return true
    }

    @IBAction func tapped(sender: AnyObject) {
        self.titleTextField.resignFirstResponder()
        self.locationTextField.resignFirstResponder()
    }
    
    @IBAction func saveNewFest(sender: AnyObject) {
        if self.titleTextField.text != "" && self.locationTextField.text != "" {
            let geoCoder: CLGeocoder = CLGeocoder()
            geoCoder.geocodeAddressString(self.locationTextField.text!, completionHandler: { (placeMarks, error) -> Void in
                if (error != nil) {
                    let alertController: UIAlertController = UIAlertController(title: "Failed to find location", message: "look up of the location \(self.locationTextField.text) has failed with the error \(error) please try setting the location again", preferredStyle: UIAlertControllerStyle.Alert)
                    let alertAction: UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                    alertController.addAction(alertAction)
                    self.delegate.managedObjectContext.deleteObject(self.festival!)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.presentViewController(alertController, animated: true, completion: nil)
                    })
                    
                } else {
                    let placeMark: CLPlacemark = placeMarks!.last! 
                    self.festival?.latitude = placeMark.location!.coordinate.latitude as NSNumber
                    self.festival?.longitude = placeMark.location!.coordinate.longitude as NSNumber
                    do {
                        try self.delegate.managedObjectContext.save()
                    } catch _ {
                    }
                    
                    let alertController: UIAlertController = UIAlertController(title: "Save successful", message: "New festival named \(self.titleTextField.text!) successfully saved", preferredStyle: UIAlertControllerStyle.Alert)
                    let alertAction: UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                        self.performSegueWithIdentifier("unwindFromAddFestVC", sender: self)
                    })
                    alertController.addAction(alertAction)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.presentViewController(alertController, animated: true, completion: nil)
                    })
                }
            })
            
            self.festival = NSEntityDescription.insertNewObjectForEntityForName("Festival", inManagedObjectContext: delegate.managedObjectContext) as? Festival
            self.festival!.title = self.titleTextField.text!
            self.festival!.date = self.datePicker.date
        } else {
            let alertController: UIAlertController = UIAlertController(title: "Fill out all fields", message: "Fill out all fields on this page before adding a new festival", preferredStyle: UIAlertControllerStyle.Alert)
            let alertaction: UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(alertaction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}
