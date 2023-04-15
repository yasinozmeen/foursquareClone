import UIKit

class PlacesModel{
    static let sharedInstance = PlacesModel()
    
    var placeName = ""
    var placeType = ""
    var placeDescripton = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongutde = ""
    
    private init(){ }
}
