//
//  SettingsViewController.swift
//  tipCalculator
//
//  Created by Morgan Bottner on 10/15/16.
//  Copyright © 2016 Morgan Bottner. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if let tip0 = defaults.string(forKey: "tip0") {
            tipControl.setTitle("\(tip0)%", forSegmentAt: 0)
        } else { tipControl.setTitle("18%", forSegmentAt: 0) }
        
        if let tip1 = defaults.string(forKey: "tip1") {
            tipControl.setTitle("\(tip1)%", forSegmentAt: 1)
        } else { tipControl.setTitle("20%", forSegmentAt: 1) }
        
        if let tip2 = defaults.string(forKey: "tip2") {
            tipControl.setTitle("\(tip2)%", forSegmentAt: 2)
        } else { tipControl.setTitle("22%", forSegmentAt: 2) }
    
        setSlider()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func updateTip(_ sender: AnyObject) {
        let tip = Int(tipSlider.value)
        let selectedIndex = tipControl.selectedSegmentIndex
        tipControl.setTitle("\(tip)%", forSegmentAt: selectedIndex)
        
        let defaults = UserDefaults.standard
        defaults.set(tip, forKey: "tip\(selectedIndex)")
        defaults.synchronize()
    }
    
    @IBAction func tipSelected(_ sender: AnyObject) {
        setSlider()
    }

    @IBAction func reset(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(Int(18), forKey: "tip0")
        defaults.set(Int(20), forKey: "tip1")
        defaults.set(Int(22), forKey: "tip2")
        defaults.synchronize()
        
        tipControl.setTitle("18%", forSegmentAt: 0)
        tipControl.setTitle("20%", forSegmentAt: 1)
        tipControl.setTitle("22%", forSegmentAt: 2)

        setSlider()
    }
    
    func setSlider() {
        let defaults = UserDefaults.standard
        let selectedIndex = tipControl.selectedSegmentIndex
        let tip = defaults.integer(forKey: "tip\(selectedIndex)")

        tipSlider.value = Float(tip)
    }
}
