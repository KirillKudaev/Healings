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

    var activityIndicator = UIActivityIndicatorView()
    
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
    
    @IBAction func publish(_ sender: Any) {
        
        showActivityIndicator()
        
        var healing = PFObject(className:"Healing")
        healing["username"] = PFUser.current()?.username
        healing["title"] = titleLabel.text
        healing["body"] = healingText.text
        healing["anon"] = anonSwitch.isOn
        
        healing.saveInBackground { (succcess, error) in
            
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if error != nil {
                self.createOkAlert(title: "Could not post healing", message: "Please try again")
            } else {
                self.createOkAlert(title: "Posted!", message: "Your healing has been posted!")
            }
        }
    }
    
    func showActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
