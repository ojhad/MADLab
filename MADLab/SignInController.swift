import UIKit
import Parse

class SignInController: UIViewController {
    
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func signInButton(sender: UIButton) {
        PFUser.logInWithUsernameInBackground(self.usernameText.text, password:self.passwordText.text) {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}