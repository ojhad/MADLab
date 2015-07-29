import UIKit
import Parse

class SignUpController: UIViewController, DatabaseDelegate {
    
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func submitButton(sender: UIButton) {
        
        //self.performSegueWithIdentifier("afterSignUp", sender: self)
        
        Database.sharedInstance.delegate = self;
        Database.sharedInstance.signUp(self.usernameText.text, email: self.emailText.text, password: self.passwordText.text)
    }
    
    func signedUp(success: Bool, error: String) {
        if success{
            println("User successfully created!")
        }
        else{
            println("Error: User creation failed!")
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