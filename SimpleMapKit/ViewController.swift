//
//  ViewController.swift
//  SimpleMapKit
//
//  Created by Alex Wibowo on 21/10/19.
//  Copyright © 2019 Alex Wibowo. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet{
            let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.addNewAnnotation(recognizer:)))
            gestureRecognizer.minimumPressDuration = 0.5
            mapView.addGestureRecognizer(gestureRecognizer)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func addNewAnnotation(recognizer: UILongPressGestureRecognizer){
        if (recognizer.state != .began) {
            return
        }
        
        let touchPoint = recognizer.location(in: mapView)
        let wayCoords = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()
        annotation.title = "New"
        annotation.coordinate = wayCoords
        mapView.addAnnotation(annotation)
    }
}


extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "locationMarkerIdentifier"
        var view: MKPinAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.annotation = annotation
            view.canShowCallout = true
            view.isDraggable = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    
}


