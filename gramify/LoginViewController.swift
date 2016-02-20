//
//  LoginViewController.swift
//  gramify
//
//  Created by John Henning on 2/16/16.
//  Copyright © 2016 John Henning. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        
    }
    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        if (userNameField.text?.isEmpty == false) {
            newUser.username = userNameField.text
            if (passwordField.text?.isEmpty == false) {
                newUser.password = passwordField.text
                newUser.signUpInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                    if success {
                        print("Yay, created a user!")
                    } else {
                        print(error?.localizedDescription)
                    }
                })
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
