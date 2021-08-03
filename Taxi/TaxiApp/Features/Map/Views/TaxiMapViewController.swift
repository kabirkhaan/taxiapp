//
//  TaxMapViewController.swift
//  TaxiApp
//
//  Created by Kabir Khan on 02.12.20.
//

import Foundation
import UIKit
import MapKit

final class TaxisMapViewController: UIViewController {
    
    private var mapView: MKMapView!
    
    override func loadView() {
        mapView = MKMapView()
        mapView.delegate = self
        view = mapView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAnnotations()
        
        var taxis: [Taxi] = [
            .init(id: "Test 1",
                  state: .active,
                  coordinate: .init(latitude: 48.87509918, longitude:  2.31837201, heading: 2)),
            .init(id: "Test 2",
                  state: .inactive,
                  coordinate: .init(latitude: 48.85607147, longitude: 2.35680795, heading: 2))
        ]
        
        let annotations: [TaxiAnnotationViewData] = taxis.compactMap({
                                            let imageName = $0.state == .active ? "taxi-active" : "taxi-inactive"
                                            let image = UIImage(named: imageName)!
                                                                        let coordinate = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
                                                                        return TaxiAnnotationViewData(coordinate: coordinate,  image: image) })
        
        add(annotations: annotations)
        
    }
    
}

private extension TaxisMapViewController {
    
    func add(annotations: [MKAnnotation]) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(annotations)
    }
    
    func registerAnnotations() {
        mapView.register(TaxiAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: TaxiAnnotationView.reusableIdentifier)
    }
}

extension TaxisMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let taxiAnnotation = annotation as? TaxiAnnotationViewData,
              let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: TaxiAnnotationView.reusableIdentifier) as? TaxiAnnotationView else {
            return nil
        }
        annotationView.configure(with: taxiAnnotation)
        
        return annotationView
    }
}

