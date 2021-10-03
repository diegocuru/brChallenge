//
//  BaseViewController.swift
//  BRTest
//
//  Created by Diego Curumaco on 2/10/21.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    // MARK: - Private
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .brGreenBrilliant
        navigationController?.navigationBar.tintColor = .brWhite
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.brWhite]
    }
}
