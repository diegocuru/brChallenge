//
//  HomeTabBarViewController.swift
//  BRTest
//
//  Created by Diego Curumaco on 2/10/21.
//

import UIKit

class HomeTabBarViewController: UITabBarController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarStyle()
    }
    
    // MARK: - Private
    
    private func setupTabBarStyle() {
        tabBar.barTintColor = .brBlack
        tabBar.isTranslucent = false
        tabBar.tintColor = .brWhite
        tabBar.unselectedItemTintColor = .brGray
        tabBar.frame.size.height = 50
        guard let tabBarItems = tabBar.items else { return }
        guard let firstItem = tabBarItems.first else { return }
        firstItem.title = NSLocalizedString("lunch", comment: "")
        firstItem.image = UIImage(assetName: .iconTabLunch)
        guard let lastItem = tabBarItems.last else { return }
        lastItem.title = NSLocalizedString("internets", comment: "")
        lastItem.image = UIImage(assetName: .iconTabInternets)
    }
    
}
