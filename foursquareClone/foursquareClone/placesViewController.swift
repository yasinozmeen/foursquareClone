//
//  placesViewController.swift
//  foursquareClone
//
//  Created by Kadir Yasin Özmen on 13.04.2023.
//

import UIKit
import ParseUI

class placesViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "addPlacesVC", sender: nil)
    }
    @objc func logOut(){
        PFUser.logOutInBackground { error in
            if error != nil{
                self.makeAlert(error: "Error", message: error?.localizedDescription ?? "Error!!")
            }else{
                self.performSegue(withIdentifier: "toLogOut", sender: nil)
            }
        }
        
    }
    func makeAlert(error:String,message:String){
        let alertController = UIAlertController(title: error, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }

}
 
