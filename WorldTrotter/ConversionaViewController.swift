//
//  ConversionaViewController.swift
//  WorldTrotter
//
//  Created by Quintin Smith on 12/31/15.
//  Copyright © 2015 Quintin Smith. All rights reserved.
//

import UIKit

class ConversionaViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        } else {
            return nil
        }
    }
    
    override func viewDidLoad() {
        //Always call super implementation of viewDidLoad
        super.viewDidLoad()
        let calendar = NSCalendar.currentCalendar()
        let hour = calendar.component(.Hour, fromDate: NSDate())
        print(hour)
        
        if hour < 12 {
            self.view.backgroundColor = UIColor.yellowColor()
        } else if hour > 12 {
            self.view.backgroundColor = UIColor.blueColor()
        } else {
            self.view.backgroundColor = UIColor.blackColor()
        }
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func farenheitFieldEditingChanged(textfield: UITextField) {
        if let text = textField.text, value = Double(text) {
            fahrenheitValue = value
        } else {
            fahrenheitValue = nil
        }
        
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    //Delegate Methods
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let letters = NSCharacterSet.letterCharacterSet()
        if string.lowercaseString.rangeOfCharacterFromSet(letters) != nil {
            return false
        }
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(".")
        let replacementTextHasDecimalSeparator = string.rangeOfString(".")
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil  {
            return false
        } else {
            return true
        }
    }
    
    
}
