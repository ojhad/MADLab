import UIKit
import Parse

class SignUpController: UIViewController, DatabaseDelegate {
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var codeText: UITextField!
    
    @IBAction func submitButton(sender: UIButton) {
        Database.sharedInstance.delegate = self;
        
        Database.sharedInstance.signUp(self.usernameText.text, email: self.emailText.text,
            password: self.passwordText.text, code: codeText.text)
    }
    
    @IBAction func StaffControl(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            codeText.hidden = true
            
            
        case 1:
            codeText.hidden = false
            
        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeText.hidden = true
    }
    
    func signedUp(success: Bool, error: String) {
        if success{
            performSegueWithIdentifier("signedUp", sender: self)
        }
        else{
            println("Error: User creation failed!")
        }
    }
}