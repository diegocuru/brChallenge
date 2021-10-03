//
//  LunchMapViewController.swift
//  BRTest
//
//  Created by Diego Curumaco on 3/10/21.
//

import UIKit
import MapKit

protocol RestaurantsMapPresenter {
    func showMap()
}

class LunchMapViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var mapView: MKMapView!
    
    // MARK: - Properties
    
    var restaurants: [Restaurant]?
    private var locationManager = CLLocationManager()
    
    // MARK: - Inits
    
    init() {
        super.init(nibName: "LunchMapViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: NSCoder) not supperted")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLocation()
        addRestaurantsAnnotations()
    }

    // MARK: - Private
    
    private func setupUI() {
        view.backgroundColor = .brGreenBrilliant
        
        navigationItem.titleView?.tintColor = .brWhite
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(assetName: .iconClose),
            style: .plain,
            target: self,
            action: #selector(onCloseTapped)
        )
        
        title = NSLocalizedString("Restaurants", comment: "")
    }
    
    private func setupLocation() {
        locationManager.requestWhenInUseAuthorization()
        let status = locationManager.authorizationStatus
        
        guard status == .authorizedWhenInUse else { return }
        
        mapView.showsUserLocation = true
    }
    
    private func addRestaurantsAnnotations() {
        guard let restaurants = restaurants else { return }
        
        var annotations = [MKAnnotation]()
        
        for restaurant in restaurants {
            guard let location = restaurant.location else { continue }
            
            let coordinate = CLLocationCoordinate2D(
                latitude: CLLocationDegrees(location.latitude),
                longitude: CLLocationDegrees(location.longitude)
            )
            
            let annotation = MKPointAnnotation()
            annotation.title = restaurant.name
            annotation.coordinate = coordinate
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
        
        guard let lastLocation = restaurants.last?.location else { return }
        
        let center = CLLocationCoordinate2D(
            latitude: CLLocationDegrees(lastLocation.latitude),
            longitude: CLLocationDegrees(lastLocation.longitude)
        )
        
        let distance = 3000.0
        
        let region = MKCoordinateRegion(
            center: center,
            latitudinalMeters: distance,
            longitudinalMeters: distance
        )
        
        mapView.setRegion(region, animated: true)
    }
    
    @objc private func onCloseTapped() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
}
