import UIKit
import ParseUI
class addPlacesViewController: UIViewController {
    @IBOutlet weak var placeNAme: UITextField!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var placeDescripton: UITextField!
    @IBOutlet weak var imageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addPlacesButton(_ sender: Any) {
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
}
