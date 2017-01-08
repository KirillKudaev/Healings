//
//  LoginViewController.swift
//  Healings
//
//  Created by Kirill Kudaev on 1/8/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    var signupMode = true
    
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signupOrLogin: UIButton!
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            // self.dismiss(animated: true, completion: nil) // Was dismissing the UIView instead of the alert.
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func signupOrLogin(_ sender: AnyObject) {
        if usernameTextField.text == "" || passwordTextField.text == "" {
            
            createAlert(title: "Error in form", message: "Please enter a username and password")
            
        } else if usernameTextField.text?.characters.index(of: " ") != nil {
        
            createAlert(title: "Error in form", message: "Please no whitespaces in username")
            
        } else if passwordTextField.text?.characters.index(of: " ") != nil {
            
            createAlert(title: "Error in form", message: "Please no whitespaces in password")
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            if signupMode {
                // Sign Up
                
                let user = PFUser()
                
                user.username = usernameTextField.text
                user.password = passwordTextField.text
                
                user.signUpInBackground(block: {(success, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        
                        let error = error as NSError?
                        
                        var displayErrorMessage = "Please try again later."
                        
                        if let errorMesage = error?.userInfo["error"] as? String {
                            displayErrorMessage = errorMesage
                        }
                        
                        self.createAlert(title: "Signup Error", message: displayErrorMessage)
                        
                    } else {
                        print("User signed up")
                        
                        self.performSegue(withIdentifier: "showFeed", sender: self)
                    }
                })
            } else {
                
                // Login mode
                
                PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!, block: { (yser, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        
                        let error = error as NSError?
                        
                        var displayErrorMessage = "Please try again later."
                        
                        if let errorMesage = error?.userInfo["error"] as? String {
                            displayErrorMessage = errorMesage
                        }
                        
                        self.createAlert(title: "Login Error", message: displayErrorMessage)
                        
                    } else {
                        print("Logged in")
                        self.performSegue(withIdentifier: "showFeed", sender: self)
                    }
                })
                
            }
        }
    }
    
    @IBOutlet weak var changeSignupModeButton: UIButton!
    
    @IBAction func changeSignupMode(_ sender: AnyObject) {
        if signupMode {
            // Change to login mode.
            
            signupOrLogin.setTitle("Log In", for: [])
            changeSignupModeButton.setTitle("Sign Up", for: [])
            messageLabel.text = "Don't have an account?"
            
            signupMode = false
        } else {
            signupOrLogin.setTitle("Sign Up", for: [])
            changeSignupModeButton.setTitle("Log In", for: [])
            messageLabel.text = "Already have an account?"
            
            signupMode = true
        }
    }
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() != nil {
            self.performSegue(withIdentifier: "showFeed", sender: self)
        }
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
 
        super.viewDidLoad()
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
