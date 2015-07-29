//
//  CreateDiscussionBoardViewController.swift
//  MADLab
//
//  Created by Dilip Ojha on 2015-07-29.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class CreateDiscussionBoardViewController: UIViewController, DatabaseDelegate{

    @IBOutlet weak var tfBoardName: UITextField!
    @IBOutlet weak var txtvBoardDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func btnTappedCreate(sender: UIButton) {
        println("Tapped Create Board.")
        Database.sharedInstance.delegate = self;
        Database.sharedInstance.createNewBoard(tfBoardName.text, description: txtvBoardDescription.text, image: nil)
    }
    @IBAction func btnTappedCancel(sender: AnyObject) {
    }
    @IBAction func btnTappedUploadImage(sender: AnyObject) {
    }
    
    //MARK: Database Callbacks
    
    func boardCreated(success: Bool, error: String) {
        if success{
            println("Board successfully created!")
        }
        else{
            println("Error: Board creation failed!")
        }
    }
    
}
