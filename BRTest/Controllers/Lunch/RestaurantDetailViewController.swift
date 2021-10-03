//
//  RestaurantDetailViewController.swift
//  BRTest
//
//  Created by Diego Curumaco on 2/10/21.
//

import UIKit
import MapKit

class RestaurantDetailViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var mapView: MKMapView!
    @IBOutlet private var nameContainerView: UIView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var categoryLabel: UILabel!
    @IBOutlet private var contactContainerView: UIView!
    @IBOutlet private var addressLabel: UILabel!
    @IBOutlet private var phoneLabel: UILabel!
    @IBOutlet private var twitterLabel: UILabel!
    
    // MARK: - Properties
    var restaurant: Restaurant?
    var restaurantsMapPresenter: RestaurantsMapPresenter?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupInfo()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        // Colors
        view.backgroundColor = .brGreenBrilliant
        nameContainerView.backgroundColor = .brGreenOpaque
        nameLabel.textColor = .brWhite
        categoryLabel.textColor = .brWhite
        contactContainerView.backgroundColor = .white
        addressLabel.textColor = .brBlack
        phoneLabel.textColor = .brBlack
        twitterLabel.textColor = .brBlack
        
        // Titles
        title = NSLocalizedString("Lunch Tyme", comment: "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(assetName: .iconMap),
            style: .plain,
            target: self,
            action: #selector(onMapTapped)
        )
    }
    
    private func setupInfo() {
        guard let restaurant = restaurant else { return }
        nameLabel.text = restaurant.name
        categoryLabel.text = restaurant.category
        if let location = restaurant.location {
            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(location.latitude), longitude: CLLocationDegrees(location.longitude))
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 300, longitudinalMeters: 300)
            mapView.setRegion(region, animated: true)
            
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.title = restaurant.name
            pointAnnotation.coordinate = coordinate
            mapView.addAnnotation(pointAnnotation)
            addressLabel.text = "\(location.address), \(location.crossStreet), \(location.state) \(location.postalCode)"
        }
        guard let contact = restaurant.contact else { return }
        phoneLabel.text = contact.formattedPhone
        twitterLabel.text = "@\(contact.twitter)"
    }
    
    @objc private func onMapTapped() {
        restaurantsMapPresenter?.showMap()
    }
}
