//
//  HealingViewController.swift
//  Healings
//
//  Created by Kirill Kudaev on 2/28/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class HealingViewController: UIViewController {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblHealingContent: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    var username = ""
    var healingTitle = ""
    var healingContent = ""
    var time = ""
    var likes = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        lblUserName.text = username
        lblTitle.text = healingTitle
        lblHealingContent.text = healingContent
        lblTime.text = time
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
