import UIKit
import Parse

class SignUpController: UIViewController {
    
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func submitButton(sender: UIButton) {
        Database.signUp(self.usernameText.text, email: self.emailText.text, password: self.passwordText.text)
        
        //self.performSegueWithIdentifier("afterSignUp", sender: self)
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