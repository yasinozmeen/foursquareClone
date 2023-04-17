import UIKit
import ParseUI
import MapKit

class detailsViewController: UIViewController,MKMapViewDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var descriptonLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var id = ""
    var latitude = Double()
    var langutude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromParse()
        mapView.delegate = self
    }
    func getDataFromParse(){
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: id)
        query.findObjectsInBackground { objects, error in
            if error != nil{
                
            }else{
                if let myObject = objects?[0]{
                    self.nameLabel.text = myObject["name"] as? String
                    self.typeLabel.text = myObject["type"] as? String
                    self.descriptonLabel.text = myObject["descripton"] as? String
                    
                    if let lat = myObject["latitude"] as? String{
                        if let lat = Double(lat){
                            self.latitude = lat
                            print(self.latitude)
                        }
                    }
                    if let lan = myObject["longutude"] as? String{
                        if let lan = Double(lan){
                            self.langutude = lan
                            print(self.langutude)
                        }
                    }
                    if let  imageData = myObject["image"] as? PFFileObject{
                        imageData.getDataInBackground { data, error in
                            if error != nil{
                                self.makeAlert(error: "Error", message: error?.localizedDescription ?? "Error")
                            }else{
                                self.imageView.image = UIImage(data: data!)
                            }
                        }
                    }
                    let location = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.langutude)
                    let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                    let region = MKCoordinateRegion(center: location, span: span)
                    self.mapView.setRegion(region, animated: true)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = self.nameLabel.text!
                    self.mapView.addAnnotation(annotation)
                }
                
            }
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if pinView == nil{
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }else{
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.langutude != 0.0 && self.latitude != 0.0{
            let requestLocation = CLLocation(latitude: latitude, longitude: langutude)
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemark, error in
                if let placemark = placemark{
                    if placemark.count > 0{
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.nameLabel.text!
                        let launchOption = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                        mapItem.openInMaps(launchOptions: launchOption)
                    }
                }
            }
        }
    }
    func makeAlert(error:String,message:String){
        let alertController = UIAlertController(title: error, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
