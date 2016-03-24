//
//  PostImageViewController.swift
//  gramify
//
//  Created by John Henning on 2/20/16.
//  Copyright © 2016 John Henning. All rights reserved.
//
// swiftlint:disable variable_name
// swiftlint:disable trailing_whitespace
// swiftlint:disable line_length

import UIKit

let userDidPostPhotoNotification = "userDidPostPhotoNotification"


class PostImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    let vc = UIImagePickerController()
    let userMedia = UserMedia()
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vc.delegate = self
        vc.allowsEditing = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func showImagePicker() {
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
            let resizedImage = resize(editedImage!, newSize: CGSize(width: 280, height: 280))
            postImageView.image = resizedImage
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    @IBAction func onChooseImage(sender: AnyObject) {
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        showImagePicker()
    }

    @IBAction func onPost(sender: AnyObject) {
        if postImageView.image != nil && captionField.text != "" {
            
            userMedia.postUserImage(postImageView.image!, withCaption: captionField.text!, withCompletion: { (success: Bool, error: NSError?) -> Void in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Posted Image Successfully")
                    NSNotificationCenter.defaultCenter().postNotificationName(userDidPostPhotoNotification, object: nil)
                }
            })
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
