import UIKit
import ParseUI

class signVC: UIViewController {
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.backBarButtonItem?.isHidden = true
    }
    @IBAction func signInButton(_ sender: Any) {
        if usernameTF.text != "" && passwordTF.text != ""{
            PFUser.logInWithUsername(inBackground:usernameTF.text!, password: passwordTF.text!) { user,error in
                if error != nil{
                    self.makeAlert(error: "Error", message: error?.localizedDescription ?? "Error!")
                }else{
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                    
                }
            }
            
        }else{
            makeAlert(error: "Error", message: "Email or Password is empty")
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if usernameTF.text != "" && passwordTF.text != ""{
            
            let user = PFUser()
            user.username = usernameTF.text!
            user.password = passwordTF.text!
            
            user.signUpInBackground(){succes,error in
                if error != nil{
                    print(1)
                    self.makeAlert(error: "Error", message: error?.localizedDescription ?? "Error!!")
                }else{
                    //Segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
        }else{
            makeAlert(error: "Error", message: "Email or Password is empty")
        }
    }
    func makeAlert(error:String,message:String){
        let alertController = UIAlertController(title: error, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    

}

