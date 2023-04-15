import UIKit
import MapKit
import ParseUI

class mapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManeger = CLLocationManager()
    var choosenLatitude = ""
    var choosenLangutude = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(save))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(back))
        
        mapView.delegate = self
        locationManeger.delegate = self
        locationManeger.desiredAccuracy = kCLLocationAccuracyBest
        locationManeger.requestWhenInUseAuthorization()
        locationManeger.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gesture:)))
        recognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(recognizer)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locaiton = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: locaiton, span: span)
        mapView.setRegion(region, animated: true)
    }
    @objc func chooseLocation(gesture:UIGestureRecognizer){
        if gesture.state == UIGestureRecognizer.State.began{
            mapView.removeAnnotations(mapView.annotations)
            let touches = gesture.location(in: self.mapView)
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            let annotion = MKPointAnnotation()
            annotion.coordinate = coordinates
            annotion.title = PlacesModel.sharedInstance.placeName
            annotion.subtitle = PlacesModel.sharedInstance.placeType
            self.mapView.addAnnotation(annotion)
            self.choosenLatitude = String(coordinates.latitude)
            self.choosenLangutude = String(coordinates.longitude)
            
        }
    }
    
    @objc func save(){
        let placeModel = PlacesModel.sharedInstance
        
        let object = PFObject(className: "Places")
        object["name"] = placeModel.placeName
        object["type"] = placeModel.placeType
        object["descripton"] = placeModel.placeDescripton
        object["latitude"] = placeModel.placeLatitude
        object["longutude"] = placeModel.placeLongutde
        
        if let imageData = placeModel.placeImage.jpegData(compressionQuality: 0.5){
            object["image"] = PFFileObject(name: "image.jpg", data: imageData)
        }
        
        object.saveInBackground { succes, error in
            if error != nil{
                self.makeAlert(error: "Error", message: error?.localizedDescription ?? "Error!")
            }else{
                self.performSegue(withIdentifier: "fromMapVCtoPlacesVC", sender: nil)
            }
        }
    }
    @objc func back(){
        dismiss(animated: true)
    }
    func makeAlert(error:String,message:String){
        let alertController = UIAlertController(title: error, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
}
