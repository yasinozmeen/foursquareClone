import UIKit
import MapKit
import ParseUI

class mapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(save))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(back))
    }
    @objc func save(){
        
    }
    @objc func back(){
        dismiss(animated: true)
    }
}
