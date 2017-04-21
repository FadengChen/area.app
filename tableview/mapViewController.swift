//
//  mapViewController.swift
//  tableview
//
//  Created by 陈发登 on 7/4/17.
//  Copyright © 2017 陈发登. All rights reserved.
//

import UIKit
import MapKit
class mapViewController: UIViewController,MKMapViewDelegate{
    var area: AreaMO!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsScale = true
        mapView.showsTraffic = true
        mapView.showsCompass = true
        mapView.showsBuildings = true
        mapView.showsUserLocation = true
        mapView.showsPointsOfInterest = true
let coder = CLGeocoder()
        coder.geocodeAddressString(area.name!) { (placemarks, error) in
            guard let placemarks = placemarks else{
            print(error ?? "发生错误")
                return
            }
            let place = placemarks.first
            let annotation = MKPointAnnotation()
            annotation.title = self.area.name
            annotation.subtitle = self.area.province
            if let loc = place?.location{
            annotation.coordinate = loc.coordinate
                self.mapView.showAnnotations([annotation], animated: true)
                self.mapView.selectAnnotation(annotation, animated: true)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if  annotation is MKUserLocation{
        return nil
        }
        let id = "biaozhu"
        var av = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKPinAnnotationView
        if av == nil{
        av = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
            av?.canShowCallout = true
        }
       let leftView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
leftView.image = UIImage(data: area.image!as Data)
  av?.leftCalloutAccessoryView = leftView
        return av
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
