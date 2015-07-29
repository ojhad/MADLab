//
//  DiscussionBoardTableViewController.swift
//  MADLab
//
//  Created by Dilip Ojha on 2015-07-29.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit
import Parse

class DiscussionBoardTableViewController: UITableViewController, DatabaseDelegate {
    
    var boards: [PFObject]? = nil
    
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
        Database.sharedInstance.delegate = self
        Database.sharedInstance.getAllBoards()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if (boards?.count != nil){
            return boards!.count
        }
        else{
            return 0
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("board_cell", forIndexPath: indexPath) as! DiscussionBoardTableViewCell
        
        // Configure the cell...
            
        var board: PFObject = self.boards![indexPath.row]
        
        cell.lblName.text = board["name"] as? String
        cell.lblDescription.text = board["description"] as? String
        var postCount: Int = board["numberOfPosts"] as! Int
        cell.lblPostCount.text = "\(postCount)"

        if board["image"] == nil{
            cell.ivImage.image = UIImage(named: "Folder-50");
        }
        else{
            var imageData: PFFile = board["image"] as! PFFile
            
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

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("show_posts", sender: self)
    }

    // MARK: - Database Delegate
    
    func pulledAllBoards(pulledBoards: [PFObject]?, error: String?) {
        if error == nil{
            self.boards = pulledBoards
            self.tableView.reloadData()
        }
        else{
            println("Error Pulling Boards: \(error)")
        }
    }
    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
*/

}
