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
    optional func createdObject(type: String, success:Bool, error: String)
    optional func pulledAllObjects(type: String, pulledObjects:[PFObject]?, error: String?)
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
    
    // MARK: Calls Handling Posts
    
    func createNewPost(board: PFObject, title: String, content: String, image: UIImage?){
        
        //var user = PFUser.currentUser()
        
        var post = PFObject(className: "Post")
        post["title"] = title
        post["content"] = content
        post["board"] = board
        post["numberOfComments"] = 0
        //post["createdBy"] = user
        
        if image != nil{
            var imageData: NSData  = UIImagePNGRepresentation(image)
            var imageFile: PFFile? = PFFile(name: "\(title)Image.png", data: imageData)
            imageFile?.saveInBackground()
            post["image"] = imageFile
        }
        
        post.saveInBackgroundWithBlock({
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                self.delegate?.createdObject!("Post", success: true, error: "No Error")
            } else {
                self.delegate?.createdObject!("Post", success: false, error: error!.description)
            }
        })
        
        board.incrementKey("numberOfPosts")
        board.saveInBackground()
        
    }
    
    func getAllPosts(board: PFObject){
        
        var queryPosts = PFQuery(className: "Post")
        
        queryPosts.whereKey("board", equalTo: board)
        
        queryPosts.findObjectsInBackgroundWithBlock({
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if (error == nil) {
                if let objects = objects as? [PFObject] {
                    self.delegate?.pulledAllObjects!("Post", pulledObjects: objects, error: nil)
                }
            }
            else {
                if let objects = objects as? [PFObject] {
                    self.delegate?.pulledAllObjects!("Post", pulledObjects: objects, error: error?.description)
                }
            }
        })

    }
    
    // MARK: Calls Handling Boards
    
    func createNewBoard(name: String, description: String, image: UIImage?){
        
        //var user = PFUser.currentUser()
        
        var board = PFObject(className: "Board")
        board["name"] = name
        board["description"] = description
        board["numberOfPosts"] = 0
        board["posts"] = []
        //board["createdBy"] = user
        
        if image != nil{
            var imageData: NSData  = UIImagePNGRepresentation(image)
            var imageFile: PFFile? = PFFile(name: "\(name)Image.png", data: imageData)
            imageFile?.saveInBackground()
            board["image"] = imageFile
        }
        
        board.saveInBackgroundWithBlock({
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                self.delegate?.createdObject!("Board", success: true, error: "No Error")
            } else {
                self.delegate?.createdObject!("Board", success: false, error: error!.description)
            }
        })
    }
    
    func getAllBoards(){
        var query = PFQuery(className: "Board")
        query.findObjectsInBackgroundWithBlock({
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil{
                if let objects = objects as? [PFObject] {
                    self.delegate?.pulledAllObjects!("Board", pulledObjects: objects, error: nil)
                }
            }
            else{
                if let objects = objects as? [PFObject] {
                    self.delegate?.pulledAllObjects!("Board", pulledObjects: objects, error: error?.description)
                }
            }
        })
    }
}