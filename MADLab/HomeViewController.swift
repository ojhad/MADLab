import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DatabaseDelegate {
    var users = [PFUser]()
    var current: PFUser!
    var checkedIn: Bool!
    var menuOptions: [String] = ["Discussion Boards", "MADLab Staff", "Currently Checked-In"]
    
    @IBOutlet weak var checkInButton: UIBarButtonItem!
    @IBOutlet weak var tvMenuOptions: UITableView!
    @IBOutlet weak var tvCheckedInStaff: UITableView!
    
    @IBAction func logOut(sender: UIBarButtonItem) {
        PFUser.logOut()
        
        self.performSegueWithIdentifier("logOut", sender: self)
    }
    
    @IBAction func checkIn(sender: UIBarButtonItem) {
        if self.checkedIn == false {
            Database.sharedInstance.checkIn(self.current)
        }
        else{
            Database.sharedInstance.checkOut(self.current)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvMenuOptions.dataSource = self
        tvMenuOptions.delegate = self
        
        tvCheckedInStaff.dataSource = self
        tvCheckedInStaff.delegate = self
        
        
        Database.sharedInstance.delegate = self
        checkedIn = false
        
        Database.sharedInstance.getCheckedIn()
        
        self.current = PFUser.currentUser()!
        
        if self.current["admin"] as! Bool == false {
            self.checkInButton.enabled = false
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        Database.sharedInstance.delegate = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tvMenuOptions){
            return menuOptions.count
        }
        else{
            return users.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(tableView == tvMenuOptions){
            let cell = tableView.dequeueReusableCellWithIdentifier("menu_item_cell", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = menuOptions[indexPath.row]
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("checkCell", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = users[indexPath.row].username
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == tvMenuOptions{
            if indexPath.row == 0{
                // enter discussion boards
                self.performSegueWithIdentifier("discussion_board", sender: self)
            }
        }
    }
    
    func checkedIn(users: [PFUser]?, error: String?){
        if(error == nil){
            var found = false
            
            self.users = users!
            
            for user in self.users {
                if user == self.current{
                    self.checkInButton.title = "Check out"
                    self.checkedIn = true
                    found = true
                }
            }
            
            if(found == false){
                self.checkInButton.title = "Check in"
                self.checkedIn = false
            }
            
            self.tvCheckedInStaff.reloadData()
        }
        else{
            println(error)
        }
    }
    
    func checkInOut(success:Bool, error: String?){
        if success{
            Database.sharedInstance.getCheckedIn()
        }
        else{
            println(error)
        }
    }
}