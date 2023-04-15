import UIKit
import ParseUI
class addPlacesViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var placeNAme: UITextField!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var placeDescripton: UITextField!
    @IBOutlet weak var imageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageview.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        imageview.addGestureRecognizer(gestureRecognizer)
    }
    
    @IBAction func addPlacesButton(_ sender: Any) {
        if placeNAme.text != "" && placeType.text != "" && placeDescripton.text != ""{
            if let choosenImage = imageview.image{
                let placeModel = PlacesModel.sharedInstance
                placeModel.placeName = placeNAme.text!
                placeModel.placeType = placeType.text!
                placeModel.placeDescripton = placeDescripton.text!
                placeModel.placeImage = choosenImage
            }
            performSegue(withIdentifier: "toMapVC", sender: nil)
        }else{
            makeAlert(error: "Error", message: "The entered are emtpy.")
        }
    }
    @objc func choosePhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageview.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    func makeAlert(error:String,message:String){
        let alertController = UIAlertController(title: error, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
}
