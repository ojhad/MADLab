//
//  NewPostViewController.swift
//  MADLab
//
//  Created by Dilip Ojha on 2015-08-05.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit
import Parse

class NewPostViewController: UIViewController, DatabaseDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var board: PFObject?
    let imagePicker = UIImagePickerController()

    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var txtvContent: UITextView!
    @IBOutlet weak var ivAttachedImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
    }

    @IBAction func tappedCreate(sender: UIBarButtonItem) {
        Database.sharedInstance.delegate = self
        Database.sharedInstance.createNewPost(board!, title: tfTitle.text, content: txtvContent.text, image: ivAttachedImage.image)
    }
    
    @IBAction func tappedAttachImage(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    //MARK: Database Callbacks
    
    func createdObject(type: String, success: Bool, error: String) {
        if type == "Post"{
            if success{
                println("Post successfully created!")
                navigationController?.popViewControllerAnimated(true)
            }
            else{
                println("Error: Post creation failed!")
            }
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            ivAttachedImage.contentMode = UIViewContentMode.ScaleAspectFit
            ivAttachedImage.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
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
