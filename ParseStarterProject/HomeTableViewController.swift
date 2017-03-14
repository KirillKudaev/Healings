//
//  HomeTableViewController.swift
//  Healings
//
//  Created by Kirill Kudaev on 1/7/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class HomeTableViewController: UITableViewController {
    
    var healingsArray = Array<Healing>()
    var refresher: UIRefreshControl!
    
    func refresh() {
        let query = PFQuery(className:"Healing")
        query.order(byDescending: "createdAt")
        query.limit = 1000
        query.findObjectsInBackground { (objects, error) -> Void in
            
            if error == nil {
                self.healingsArray.removeAll()

                for object in objects! {
                    
                    var healing: Healing
                                    
                    if (object["anon"] as! Bool == true) {
                        healing = Healing(anon: object["anon"] as! Bool,
                                          title: object["title"] as! String,
                                          body: object["body"] as! String,
                                          createdAt: object.createdAt!,
                                          updatedAt: object.updatedAt!,
                                          numOfLikes: (object["likes"] as! Int))
                    } else {
                        healing = Healing(userName: object["username"] as! String,
                                          anon: object["anon"] as! Bool,
                                          title: object["title"] as! String,
                                          body: object["body"] as! String,
                                          createdAt: object.createdAt!,
                                          updatedAt: object.updatedAt!,
                                          numOfLikes: (object["likes"] as! Int))
                    }
                    
                    self.healingsArray.append(healing)
                }
                
                print("Count: " + String(self.healingsArray.count))
                
                // Reload tableview
                self.tableView.reloadData()
            } else {
                print(error)
            }
            
            self.refresher.endRefreshing()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Refreshing...")
        refresher.addTarget(self, action: #selector(HomeTableViewController.refresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refresher)
        
        refresh()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Customizing Tab Bar
        let color = UIColor(red: 85/255.0, green: 199/255.0, blue: 147/255.0, alpha: 1.0)
        self.tabBarController?.tabBar.tintColor = color
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.healingsArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HealingCell
        
        // Configure the cell...
        if (self.healingsArray[indexPath.row].userName != nil) {
            cell.userNameLabel.text = self.healingsArray[indexPath.row].userName
        } else {
            cell.userNameLabel.text = "anon"
        }
        
        cell.titleLabel.text = self.healingsArray[indexPath.row].title
        cell.healingContentLabel.text = self.healingsArray[indexPath.row].body
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy HH:mm:ss"
        let createdAt = dateFormatter.string(from:self.healingsArray[indexPath.row].createdAt)
        
        cell.lblTime.text = createdAt
        cell.lblLikes.text = String(self.healingsArray[indexPath.row].numOfLikes)
        //cell.userImage.image = UIImage(named: "AnonMask.png")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.indexPathForSelectedRow!
        if let _ = tableView.cellForRow(at: indexPath) {
            self.performSegue(withIdentifier: "showHealing", sender: self)
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHealing" {
            if let destination = segue.destination as? HealingViewController {
                
                let path = tableView.indexPathForSelectedRow
                let cell = tableView.cellForRow(at: path!) as! HealingCell
                
                destination.username = (cell.userNameLabel.text)!
                destination.healingTitle = (cell.titleLabel.text)!
                destination.healingContent = (cell.healingContentLabel.text)!
                destination.time = (cell.lblTime.text)!
            }
        }
    }
}

