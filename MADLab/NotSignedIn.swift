//
//  NotSignedIn.swift
//  MADLab
//
//  Created by Rodolfo Martinez on 2015-08-05.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit
import Parse

class NotSignedIn: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            dispatch_async(dispatch_get_main_queue(), {
                self.performSegueWithIdentifier("signedIn", sender: self)
            })
        }
    }
}
    