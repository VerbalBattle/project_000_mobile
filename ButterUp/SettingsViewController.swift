//
//  SettingsViewController.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 03.11.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var logout: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func logout(sender: AnyObject) {
        Auth().signOut()
    }

    
}
