//
//  AddItemViewController.swift
//  Festi Buddy
//
//  Created by Justin Oakes on 8/20/15.
//  Copyright © 2015 Oklasoft. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var itemNameTextField: UITextField!
    
    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        self.itemNameTextField.delegate = self
    }
    override func viewDidAppear(animated: Bool) {
        self.itemNameTextField.becomeFirstResponder()
    }
    
    
    @IBAction func save(sender: AnyObject) {
        let customItem: Items = NSEntityDescription.insertNewObjectForEntityForName("Items", inManagedObjectContext: self.delegate.managedObjectContext) as! Items
        customItem.name = self.itemNameTextField.text!
        customItem.have = false
        
        do {
            try delegate.managedObjectContext.save()
        } catch {
            print("failed to save new item to core data store")
        }
//          adding new item to apple watch
        let itemDictionary: [String: AnyObject] = ["Item": customItem.name, "have": false]
        delegate.updateWatchUserDefaultsWithDictionary(itemDictionary)
        
        self.itemNameTextField.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        self.itemNameTextField.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
// MARK: text field delegate methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.save(self)
        
        return true
    }
}
