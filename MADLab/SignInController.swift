import UIKit
import Parse

class SignInController: UIViewController, DatabaseDelegate {
    
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func signInButton(sender: UIButton) {
        Database.sharedInstance.delegate = self;
        Database.sharedInstance.logIn(self.usernameText.text, password: self.passwordText.text)
    }
    
    func loggedIn(success: Bool, error: String) {
        if success{
            println("User successfully logged in!")
            performSegueWithIdentifier("signedIn", sender: self)
        }
        else{
            println("Error: User log in failed!")
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