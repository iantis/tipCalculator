//
//  ViewController.swift
//  tipCalculator
//
//  Created by Morgan Bottner on 10/15/16.
//  Copyright © 2016 Morgan Bottner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    var tipPercentages = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        tipPercentages = [18, 20, 22]
        var count = 0
        
        for _ in tipPercentages {
            tipPercentages[count] = defaults.integer(forKey: "tip\(count)")
            let newTip = tipPercentages[count]
            if newTip > 0 {
                tipControl.setTitle("\(newTip)%", forSegmentAt: count)
            } else {
                tipControl.setTitle("18%", forSegmentAt: count)
            }
            count += 1
        }
        if ((billField.text) != nil) { calculateTip(billField) } else {
            tipLabel.text = "$0.00"
            totalLabel.text = "$0.00"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        billField.becomeFirstResponder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        // calculate bill, tip and total values
        let percent = (Double(tipPercentages[tipControl.selectedSegmentIndex]))/100
        let bill = Double(billField.text!) ?? 0
        let tip = bill * percent
        let total = bill + tip
        
        // set labels to calculated values
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)

        // INCOMPLETE Format bill input text field to local currency format
        /*
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        let billFieldNumber = NSDecimalNumber(string: billField.text)
        let formattedString = formatter.string(from: billFieldNumber)
        billField.text = formattedString
        */
    }
    
}

