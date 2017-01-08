//
//  LoginViewController.swift
//  Healings
//
//  Created by Kirill Kudaev on 1/8/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {

    var signupMode = true
    
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
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
            
        } else if signupMode && (firstNameTextField.text == "" || lastNameTextField.text == "") {
            
            createAlert(title: "Error in form", message: "Please enter a name")
            
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
                user["firstName"] = firstNameTextField.text
                user["lastName"] = lastNameTextField.text
                
            
                
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
            pleaseMessageLabel.text = "Please enter username and password:"
            messageLabel.text = "Don't have an account?"
            firstNameTextField.isHidden = true
            lastNameTextField.isHidden = true

            
            signupMode = false
        } else {
            signupOrLogin.setTitle("Sign Up", for: [])
            changeSignupModeButton.setTitle("Log In", for: [])
            pleaseMessageLabel.text = "Please register:"
            messageLabel.text = "Already have an account?"
            firstNameTextField.isHidden = false
            lastNameTextField.isHidden = false
            
            signupMode = true
        }
    }
    
    @IBOutlet weak var pleaseMessageLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() != nil {
            self.performSegue(withIdentifier: "showFeed", sender: self)
        }
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.usernameTextField {
            // Jump to password field from username field
            self.passwordTextField.becomeFirstResponder()
        } else if textField == self.passwordTextField && signupMode {
            self.firstNameTextField.becomeFirstResponder()
        } else if textField == self.firstNameTextField {
            self.lastNameTextField.becomeFirstResponder()
        } else {
            // Otherwise close keyboard
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
