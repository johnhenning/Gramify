//
//  ProfileViewController.swift
//  gramify
//
//  Created by John Henning on 2/20/16.
//  Copyright © 2016 John Henning. All rights reserved.
//

import UIKit
import Parse

let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = PFUser.currentUser()?.username
        usernameLabel.sizeToFit()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignOut(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
            
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                print("Successfuly logged out")
                NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
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
