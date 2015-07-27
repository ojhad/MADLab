//
//  HomeViewController.swift
//  MADLab
//
//  Created by Dilip Ojha on 2015-07-27.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tvMenuOptions: UITableView!
    @IBOutlet weak var tvCheckedInStaff: UITableView!
    
    var menuOptions: [String] = ["Discussion Boards", "MADLab Staff", "Currently Checked-In"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvMenuOptions.dataSource = self
        tvMenuOptions.delegate = self
        tvMenuOptions.separatorStyle = UITableViewCellSeparatorStyle.None
        tvMenuOptions.scrollEnabled = false


    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(tableView == tvMenuOptions){
            let cell = tableView.dequeueReusableCellWithIdentifier("menu_item_cell", forIndexPath: indexPath) as! UITableViewCell
            
            cell.textLabel?.text = menuOptions[indexPath.row]
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
            
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


    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
