import UIKit
import ParseUI

class placesViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    var placesNameArray = [String]()
    var placesIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        getDataFromParse()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesNameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var context = cell.defaultContentConfiguration()
        context.text = placesNameArray[indexPath.row]
        cell.contentConfiguration = context
        return cell
    }
    
    func getDataFromParse(){
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { objects, error in
            if error != nil{
                self.makeAlert(error: "Error", message: error?.localizedDescription ?? "Error!!")
            }else{
                
                self.placesNameArray.removeAll()
                self.placesIdArray.removeAll()
                
                for object in objects!{
                    if let placeName = object.object(forKey: "name") as? String{
                        if let placeId = object.objectId as? String{
                           
                            self.placesNameArray.append(placeName)
                            self.placesIdArray.append(placeId)
                            
                        }
                    }
                }
                self.tableview.reloadData()
            }
        }
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
 
