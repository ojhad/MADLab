//
//  HomeViewController.swift
//  MADLab
//
//  Created by Dilip Ojha on 2015-07-29.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DatabaseDelegate {
    
    var users = [PFUser]()
    
    var current: PFUser!
    
    var checkedIn: Bool!
    
    @IBAction func logOut(sender: UIBarButtonItem) {
        PFUser.logOut()
        
        performSegueWithIdentifier("logOut", sender: self)
    }
    
    @IBOutlet weak var checkInButton: UIBarButtonItem!
    
    @IBAction func checkIn(sender: UIBarButtonItem) {
        if self.checkedIn == false {
            Database.sharedInstance.checkIn(self.current)
        }
        else{
            Database.sharedInstance.checkOut(self.current)
        }
    }
    
    @IBOutlet weak var tvMenuOptions: UITableView!
    @IBOutlet weak var tvCheckedInStaff: UITableView!
    
    var menuOptions: [String] = ["Discussion Boards", "MADLab Staff", "Currently Checked-In"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvMenuOptions.dataSource = self
        tvMenuOptions.delegate = self
        tvMenuOptions.separatorStyle = UITableViewCellSeparatorStyle.None
        tvMenuOptions.scrollEnabled = false
        
        tvCheckedInStaff.dataSource = self
        tvCheckedInStaff.delegate = self
        
        
        Database.sharedInstance.delegate = self
        checkedIn = false
        
        Database.sharedInstance.getCheckedIn()
        
        self.current = PFUser.currentUser()!
        
        self.title = self.current.username!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tvMenuOptions){
            return menuOptions.count
        }
        else{
            return users.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(tableView == tvMenuOptions){
            let cell = tableView.dequeueReusableCellWithIdentifier("menu_item_cell", forIndexPath: indexPath) as! UITableViewCell
            
            cell.textLabel?.text = menuOptions[indexPath.row]
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("checkCell", forIndexPath: indexPath) as! UITableViewCell
            
            cell.textLabel?.text = users[indexPath.row].username
            
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == tvMenuOptions{
            if indexPath.row == 0{ // enter discussion boards
                self.performSegueWithIdentifier("discussion_board", sender: self)
            }
        }
    }
    
    func checkedIn(users: [PFUser]?, error: String?){
        if(error == nil){
            var found = false
            
            self.users = users!
            
            for user in self.users {
                if user == self.current{
                    self.checkInButton.title = "Check out"
                    self.checkedIn = true
                    found = true
                }
            }
            
            if(found == false){
                self.checkInButton.title = "Check in"
                self.checkedIn = false
            }
            
            self.tvCheckedInStaff.reloadData()
        }
        else{
            println(error)
        }
    }
    
    func checkIn(success:Bool, error: String?){
        if success{
            Database.sharedInstance.getCheckedIn()
        }
        else{
            println("Error: User checking in failed!")
        }
    }
    
    func checkOut(success:Bool, error: String?){
        if success{
            Database.sharedInstance.getCheckedIn()
        }
        else{
            println("Error: User checking out failed!")
        }
    }
    
    func refresh(sender:AnyObject){
        Database.sharedInstance.getCheckedIn()
    }
}
