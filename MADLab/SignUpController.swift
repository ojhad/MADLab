import UIKit
import Parse

class SignUpController: UIViewController {
    
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func submitButton(sender: UIButton) {
        
        var user = PFUser()
        user.username = self.usernameText.text
        user.email = self.emailText.text
        user.password = self.passwordText.text
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}