//
//  RestaurantCollectionViewCell.swift
//  BRTest
//
//  Created by Diego Curumaco on 2/10/21.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var categoryLabel: UILabel!
    
    // MARK: - Properties
    
    let identifier = String(describing: self)
    var restaurant: Restaurant? {
        didSet {
            updateInfo()
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Methods
    
    func updateImage(image: UIImage) {
        imageView.alpha = 0.0
        imageView.image = image
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.imageView.alpha = 1.0
        }
    }
    
    // MARK: - Private
    
    private func updateInfo() {
        guard let restaurant = restaurant else {
            return
        }
        guard let _ = imageView, let nameLabel = nameLabel, let categoryLabel = categoryLabel else {
            assert(false, "Call updateInfo after outlets have been loaded")
        }
        nameLabel.text = restaurant.name
        categoryLabel.text = restaurant.category
    }
}
