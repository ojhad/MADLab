import UIKit
import Parse

class SignInController: UIViewController, DatabaseDelegate {
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func signInButton(sender: UIButton) {
        Database.sharedInstance.delegate = self;
        Database.sharedInstance.logIn(self.usernameText.text, password: self.passwordText.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loggedIn(success: Bool, error: String) {
        if success{
            performSegueWithIdentifier("signedIn", sender: self)
        }
        else{
            println("Error: User log in failed!")
        }
    }
}