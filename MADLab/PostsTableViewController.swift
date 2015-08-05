//
//  PostsTableViewController.swift
//  MADLab
//
//  Created by Dilip Ojha on 2015-08-05.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit
import Parse

class PostsTableViewController: UITableViewController, DatabaseDelegate {
    
    var board: PFObject?
    var posts: [PFObject]? = nil


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.updateData()
        
        self.tableView.estimatedRowHeight = 80.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(animated: Bool) {
        self.updateData()
    }

    func updateData(){
        Database.sharedInstance.delegate = self;
        Database.sharedInstance.getAllPosts(board!)
    }
    
    // MARK: - Database Delegate
    
    func pulledAllObjects(type: String, pulledObjects: [PFObject]?, error: String?) {
        if type == "Post"{
            if error == nil{
                self.posts = pulledObjects
                self.tableView.reloadData()
            }
            else{
                println("Error Pulling Boards: \(error)")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if (posts?.count != nil){
            return posts!.count
        }
        else{
            return 0
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("post_cell", forIndexPath: indexPath) as! PostTableViewCell

        var post: PFObject = self.posts![indexPath.row]
        
        cell.lblTitle.text = post["title"] as? String
        
        var postCount: Int = post["numberOfComments"] as! Int
        cell.lblCommentCount.text = "\(postCount)"
        
        var date: NSDate? =  post.createdAt
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE MMM dd - hh:mm a"
        var dateString: String = dateFormatter.stringFromDate(date!)
        
        cell.lblDate.text = dateString
        
        if post["image"] == nil{
            cell.ivImage.image = UIImage(named: "Folder-50");
        }
        else{
            var imageData: PFFile = post["image"] as! PFFile
            
            imageData.getDataInBackgroundWithBlock({
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        cell.ivImage.image = image
                    }
                }
            })
            
        }


        return cell
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "new_post"{
            var vc: NewPostViewController = segue.destinationViewController as! NewPostViewController
            vc.board = self.board
        }
        
    }

}
