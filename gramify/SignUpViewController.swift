//
//  SignUpViewController.swift
//  gramify
//
//  Created by John Henning on 2/20/16.
//  Copyright © 2016 John Henning. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
            
            if (usernameField.text != "" && passwordField.text != "" && emailField.text != "") {
                // initialize a user object
                let newUser = PFUser()
                
                // set user properties
                newUser.username = usernameField.text
                newUser.password = passwordField.text
                newUser.email = emailField.text
                
                // call sign up function on the object
                newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                    if let error = error {
                        print(error.localizedDescription)
                        if (error.code == 202) {
                            let alertController = UIAlertController(title: "Username Already Exists", message: "", preferredStyle: .Alert)
                            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                            }
                            alertController.addAction(OKAction)
                            self.presentViewController(alertController, animated: true) {
                            }
                        }
                        if (error.code == 203) {
                            let alertController = UIAlertController(title: "Email Already Exists", message: "", preferredStyle: .Alert)
                            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                            }
                            alertController.addAction(OKAction)
                            self.presentViewController(alertController, animated: true) {
                            }
                        }
                        if (error.code == 125) {
                            let alertController = UIAlertController(title: "Email Address Format Is Invalid", message: "example: abc@gmail.com", preferredStyle: .Alert)
                            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                            }
                            alertController.addAction(OKAction)
                            self.presentViewController(alertController, animated: true) {
                            }
                        }
                    } else {
                        print("User Registered successfully")
                        // manually segue to logged in view
                        self.performSegueWithIdentifier("SignupHomeSegue", sender: nil)
                    }
                }
            }
                
            else if (usernameField.text == "") {
                let alertController = UIAlertController(title: "Missing Username", message: "", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                }
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true) {
                }
            }
            else if (passwordField.text == "") {
                let alertController = UIAlertController(title: "Missing Password", message: "", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                }
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true) {
                }
            }
            else if (emailField.text == "") {
                let alertController = UIAlertController(title: "Missing Email", message: "", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                }
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true) {
                }
            }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
