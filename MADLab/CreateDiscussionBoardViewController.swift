//
//  CreateDiscussionBoardViewController.swift
//  MADLab
//
//  Created by Dilip Ojha on 2015-07-29.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class CreateDiscussionBoardViewController: UIViewController, DatabaseDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var tfBoardName: UITextField!
    @IBOutlet weak var txtvBoardDescription: UITextView!
    
    @IBOutlet weak var btnSelectImage: UIButton!
    @IBOutlet weak var ivSelectedImage: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

    }


    @IBAction func btnTappedCreate(sender: AnyObject) {
        Database.sharedInstance.delegate = self;
        Database.sharedInstance.createNewBoard(tfBoardName.text, description: txtvBoardDescription.text, image: ivSelectedImage.image)
    }
    
    @IBAction func btnTappedUploadImage(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            ivSelectedImage.contentMode = UIViewContentMode.ScaleToFill
            ivSelectedImage.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Database Callbacks
    
    func createdObject(type: String, success: Bool, error: String) {
        if type == "Board"{
            if success{
                println("Board successfully created!")
                navigationController?.popViewControllerAnimated(true)
            }
            else{
                println("Error: Board creation failed!")
            }
        }
    }
    
    
}
