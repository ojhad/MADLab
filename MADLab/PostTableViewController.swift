//
//  PostTableViewController.swift
//  MADLab
//
//  Created by Dilip Ojha on 2015-08-07.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit
import Parse

class PostTableViewController: UITableViewController {
    
    var post: PFObject?
    
    var testComments: [String] = ["Wow. That's pretty cool!","Can you elaborate.", "I might implement this in my app. I just have a question about this certain point.","Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.separatorStyle = .None
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return ""
        }
        else{
            return "Comments"
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 0{
            return 3
        }
        else{
            return testComments.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && indexPath.row == 0{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("title_cell", forIndexPath: indexPath) as! UITableViewCell
            
            cell.textLabel?.text = post!["title"] as? String
            
            return cell
        }
        else if indexPath.section == 0 && indexPath.row == 1{
            
            
            let cell = tableView.dequeueReusableCellWithIdentifier("content_cell", forIndexPath: indexPath) as! UITableViewCell
            
            cell.textLabel?.text = post!["content"] as? String
            
            return cell
        }
        else if indexPath.section == 0 && indexPath.row == 2{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("image_cell", forIndexPath: indexPath) as! ImageTableViewCell

            if post!["image"] == nil{
            }
            else{
                var imageData: PFFile = post!["image"] as! PFFile
                
                imageData.getDataInBackgroundWithBlock({
                    (imageData: NSData?, error: NSError?) -> Void in
                    if error == nil {
                        if let imageData = imageData {
                            let image = UIImage(data:imageData)
                            cell.ivImage.image = image
                            cell.ivImage.contentMode = UIViewContentMode.ScaleAspectFit
                            
                        }
                    }
                })
                
            }
            return cell

        }
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCellWithIdentifier("content_cell", forIndexPath: indexPath) as! UITableViewCell
            
            cell.textLabel?.text = testComments[indexPath.row]
            
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
            return cell

        }
    
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1{
            if indexPath.row % 2 != 0{
                cell.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1.0)
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
