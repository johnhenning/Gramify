//
//  HomeViewController.swift
//  gramify
//
//  Created by John Henning on 2/20/16.
//  Copyright © 2016 John Henning. All rights reserved.
//
// swiftlint:disable variable_name
// swiftlint:disable trailing_whitespace
// swiftlint:disable line_length

import UIKit
import Parse



class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var userMedia: [PFObject]?
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        //tableView.estimatedRowHeight = 335
        //tableView.rowHeight = UITableViewAutomaticDimension
        
        ParseServerCall()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userMedia != nil {
            return userMedia!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeTableViewCell", forIndexPath: indexPath) as? HomeTableViewCell
        
        if userMedia?[indexPath.row]["media"] != nil {
            let userImageFile = userMedia?[indexPath.row]["media"] as? PFFile
            userImageFile!.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    let image = UIImage(data: imageData!)
                    cell!.pictureView.image = image
                }
            })
        }
        
        if userMedia?[indexPath.row]["caption"] != nil {
            cell!.captionLabel.text = userMedia![indexPath.row]["caption"] as? String
        }
        
        if userMedia?[indexPath.row].createdAt != nil {
            var createdAt = ""
            let formatter = NSDateFormatter()
            formatter.dateStyle = .ShortStyle
            createdAt = formatter.stringFromDate(userMedia![indexPath.row].createdAt!)
            cell!.createdAtLabel.text = createdAt
        }
        

        return cell!
    }
    
    func ParseServerCall() {
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                // do something with the data fetched
                //                print(media)
                self.userMedia = media
                self.tableView.reloadData()
                
                //                print("\(media[1].createdAt)")
                
            } else {
                // handle error
            }
        }
    }
    
    func delay(delay: Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    func onRefresh() {
        delay(2, closure: {
            self.refreshControl.endRefreshing()
        })
        
        ParseServerCall()
        
        self.refreshControl?.endRefreshing()
    }
    
    
    func testQuery() {
        let query = PFQuery(className: "UserMedia")
        query.getObjectInBackgroundWithId("dCgHoQRsXr") {
            (userMedia: PFObject?, error: NSError?) -> Void in
            if error == nil {
                print(userMedia)
            } else {
                print(error)
            }
        }
    }

   
}
