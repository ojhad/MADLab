//
//  Database.swift
//  MADLab
//
//  Created by Rodolfo Martinez on 2015-07-29.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import Foundation
import Parse

@objc protocol DatabaseDelegate{
    optional func boardCreated(success:Bool, error: String)
}

class Database: NSObject{
    
    class var sharedInstance : Database {
        struct Static {
            static let instance : Database = Database()
        }
        return Static.instance
    }
    
    var delegate:DatabaseDelegate? = nil
    
    func logIn(userName: String, password: String){
        PFUser.logInWithUsernameInBackground(userName, password: password) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                let alert = UIAlertView()
                alert.title = "Success"
                alert.message = "Welcome!"
                alert.addButtonWithTitle("OK")
                alert.show()
                
            } else {
                // The login failed. Check error to see why.
                let errorString = error!.userInfo?["error"] as? String
                let alert = UIAlertView()
                alert.title = "Error"
                alert.message = errorString
                alert.addButtonWithTitle("OK")
                alert.show()
            }
        }
    }
    
    func signUp(username: String, email: String, password: String) {
        var user = PFUser()
        
        user.username = username
        user.email = email
        user.password = password
        
        user["checkedIn"]=true
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? String
                // Show the errorString somewhere and let the user try again.
                
                let alert = UIAlertView()
                alert.title = "Error"
                alert.message = errorString
                alert.addButtonWithTitle("OK")
                alert.show()
                
            } else {
                // Hooray! Let them use the app now.
                
                let alert = UIAlertView()
                alert.title = "Success"
                alert.message = "Welcome!"
                alert.addButtonWithTitle("OK")
                alert.show()
            }
        }
    }
    
    func createNewBoard(name: String, description: String, image: UIImage?){
        
        //var user = PFUser.currentUser()
        
        var board = PFObject(className: "Board")
        board["name"] = name
        board["description"] = description
        board["numberOfPosts"] = 0
        //board["createdBy"] = user
        
        board.saveInBackgroundWithBlock({
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                self.delegate?.boardCreated!(true, error: "No Error.")
            } else {
                self.delegate?.boardCreated!(false, error: error!.description)
            }
        })
        
        
    }
}