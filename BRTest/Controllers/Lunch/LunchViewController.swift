//
//  LunchViewController.swift
//  BRTest
//
//  Created by Diego Curumaco on 2/10/21.
//

import UIKit

class LunchViewController: BaseViewController {

    // MARK: - Outlets
    
    @IBOutlet private var restaurantsCollectionView: UICollectionView!
    
    // MARK: - Variables
    
    private var restaurants: [Restaurant]?
    private let segueToDetail = "RestaurantDetail"
    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    private lazy var lunchMapViewController = {
      return LunchMapViewController()
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAndShowRestaurants()
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == segueToDetail else { return }
        guard let restaurant = sender as? Restaurant, let detailViewController = segue.destination as? RestaurantDetailViewController else {
            return
        }
        detailViewController.restaurant = restaurant
        detailViewController.restaurantsMapPresenter = self
    }
    
    // MARK: - Orientation
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        restaurantsCollectionView.layoutIfNeeded()
        restaurantsCollectionView.reloadData()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        view.backgroundColor = .brGreenBrilliant
        
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.title = NSLocalizedString("Lunch Tyme", comment: "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(assetName: .iconMap),
            style: .plain,
            target: self,
            action: #selector(onMapTapped)
        )
        
        restaurantsCollectionView.delegate = self
        restaurantsCollectionView.dataSource = self
        restaurantsCollectionView.registerReusableCell(RestaurantCollectionViewCell.self)
        restaurantsCollectionView.showsVerticalScrollIndicator = false
        restaurantsCollectionView.backgroundColor = .brBlack
    }
    
    private func loadAndShowRestaurants() {
        utilityQueue.async {
            RestaurantRepository.getRestaurants(completionBlock: { [weak self] apiError, restaurants in
                if let _ = apiError {
                    // TODO: - Handle error
                    return
                }
                guard let restaurants = restaurants else {
                    return
                }
                DispatchQueue.main.async {
                    self?.restaurants = restaurants
                    self?.restaurantsCollectionView.reloadData()
                }
            })
        }
    }
    
    @objc private func onMapTapped() {
        showMap()
    }
}

// MARK: - Extensions

// MARK: - Collection View Data Source

extension LunchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let restaurants = restaurants else { return 0 }
        return restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let restaurants = restaurants else {
            return UICollectionViewCell()
        }
        let restaurant = restaurants[indexPath.item]
        let restaurantCell = collectionView.dequeueReusableCell(for: indexPath) as RestaurantCollectionViewCell
        restaurantCell.restaurant = restaurant
        return restaurantCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let restaurantCollectionViewCell = cell as? RestaurantCollectionViewCell else { return }
        guard let backgroundImageURL = restaurantCollectionViewCell.restaurant?.backgroundImageURL else { return }
        
        let itemIndex = NSNumber(integerLiteral: indexPath.item)
        if let cachedImage = cache.object(forKey: itemIndex) {
            restaurantCollectionViewCell.updateImage(image: cachedImage)
            return
        }
        
        utilityQueue.async {
            API.getImage(from: backgroundImageURL) { apiError, image in
                if let apiError = apiError {
                    print(apiError.message)
                    return
                }
                
                guard let image = image else { return }
                DispatchQueue.main.async { [weak self] in
                    restaurantCollectionViewCell.updateImage(image: image)
                    self?.cache.setObject(image, forKey: itemIndex)
                }
            }
        }
    }
}

// MARK: - Collection View Delegate

extension LunchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let restaurants = restaurants else { return }
        performSegue(withIdentifier: segueToDetail, sender: restaurants[indexPath.item])
    }
    
}

// MARK: - Collection View Delegate Flow Layout

extension LunchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let idiom = UIScreen.main.traitCollection.userInterfaceIdiom
        let width = idiom == .pad ? collectionView.frame.size.width / 2 : collectionView.frame.size.width
        let height = collectionView.frame.size.height / 2.8
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

// MARK: - Restaurants Map Presenter

extension LunchViewController: RestaurantsMapPresenter {
    func showMap() {
        lunchMapViewController.restaurants = restaurants
        let navigationController = UINavigationController(rootViewController: lunchMapViewController)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}
