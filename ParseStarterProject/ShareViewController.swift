//
//  ShareViewController.swift
//  Healings
//
//  Created by Kirill Kudaev on 1/8/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class ShareViewController: UIViewController {

    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var healingText: UITextView!
    
    @IBOutlet weak var anonSwitch: UISwitch!
    
    @IBOutlet weak var leftMaskImage: UIImageView!
    @IBOutlet weak var rightMaskImage: UIImageView!
    
    @IBAction func makeAnon(_ sender: Any) {
        if anonSwitch.isOn {
            leftMaskImage.image = UIImage(named: "AnonMask.png")
            rightMaskImage.image = UIImage(named: "AnonMask.png")
        } else {
            leftMaskImage.image = UIImage(named: "")
            rightMaskImage.image = UIImage(named: "")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
