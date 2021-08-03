//
//  MapTaxisViewController.swift
//  TaxiApp
//
//  Created by Kabir Khan on 02.12.20.
//

import Foundation
import UIKit
import MapKit

final class MapTaxisViewController: UIViewController {
    
    private var mapView: MKMapView!
    private let viewModel: MapTaxisViewModel
    
    init(with viewModel: MapTaxisViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        preconditionFailure("Should be initialized with view model")
    }
    
    override func loadView() {
        mapView = MKMapView()
        mapView.delegate = self
        view = mapView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAnnotations()
        registerStateChangeEvent()
        viewModel.refresh()
    }
    
}

private extension MapTaxisViewController {
    
    func add(annotations: [MKAnnotation]) {
        for annotation in annotations {
            if mapView.view(for: annotation) == nil {
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    func registerAnnotations() {
        mapView.register(TaxiAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: TaxiAnnotationView.reusableIdentifier)
    }
    
    func registerStateChangeEvent() {
        viewModel.onStateChange = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading: break
            case .updated(let annotations):
                self.add(annotations: annotations)
            case .error(let message):
                self.showAlert(title: nil, message: message)
            }
        }
    }
}

extension MapTaxisViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let taxiAnnotation = annotation as? TaxiAnnotationViewData,
              let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: TaxiAnnotationView.reusableIdentifier) as? TaxiAnnotationView else {
            return nil
        }
        annotationView.configure(with: taxiAnnotation)
        
        return annotationView
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        viewModel.refresh()
    }
}

