//
//  PostViewController.swift
//  MADLab
//
//  Created by Dilip Ojha on 2015-08-05.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController {
    
    var post: PFObject?

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblTitle.text = post!["title"] as? String
        lblContent.text = post!["content"] as? String
    }

    @IBAction func tappedViewAttachedImage(sender: AnyObject) {
        
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
