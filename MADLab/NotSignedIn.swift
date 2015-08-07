import UIKit
import Parse

class NotSignedIn: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            dispatch_async(dispatch_get_main_queue(), {
                self.performSegueWithIdentifier("alreadysignedIn", sender: self)
            })
        }
    }
}
    