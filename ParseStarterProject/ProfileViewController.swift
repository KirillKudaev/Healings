//
//  ProfileViewController.swift
//  Healings
//
//  Created by Kirill Kudaev on 1/8/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func logout(_ sender: AnyObject) {
        
        PFUser.logOut()
        
        performSegue(withIdentifier: "logoutSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title  = PFUser.current()?.username
        
        if (PFUser.current()?["firstName"] != nil && PFUser.current()?["lastName"] != nil) {
            nameLabel.text = (PFUser.current()?["firstName"] as! String) + " " + (PFUser.current()?["lastName"] as! String)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
