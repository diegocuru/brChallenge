//
//  InternetsViewController.swift
//  BRTest
//
//  Created by Diego Curumaco on 2/10/21.
//

import UIKit
import WebKit

class InternetsViewController: BaseViewController {

    // MARK: - Properties
    
    private let defaultSite = "https://www.bottlerocketstudios.com"
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = .clear
        webView.navigationDelegate = self
        return webView
    }()
    
    private lazy var backButtonItem = {
        return UIBarButtonItem(
            image: UIImage(assetName: .iconWebBack),
            style: .plain,
            target: self,
            action: #selector(onBackTapped)
        )
    }()
    
    private lazy var refreshButtonItem = {
        return UIBarButtonItem(
            image: UIImage(assetName: .iconWebRefresh),
            style: .plain,
            target: self,
            action: #selector(onRefreshTapped)
        )
    }()
    
    private lazy var forwardButtonItem = {
        return UIBarButtonItem(
            image: UIImage(assetName: .iconWebForward),
            style: .plain,
            target: self,
            action: #selector(onForwardTapped)
        )
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    
    @objc private func onBackTapped() {
        guard webView.canGoBack else { return }
        webView.goBack()
        updateNavigationButtons()
    }
    
    @objc private func onRefreshTapped() {
        guard webView.url != nil else { return }
        webView.reload()
        updateNavigationButtons()
    }
    
    @objc private func onForwardTapped() {
        guard webView.canGoForward else { return }
        webView.goForward()
        updateNavigationButtons()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        view.backgroundColor = .brGreenBrilliant
        
        view.addSubview(webView)
        
        navigationItem.leftBarButtonItems = [
            backButtonItem,
            refreshButtonItem,
            forwardButtonItem
        ]
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        guard let url = URL(string: defaultSite)  else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        updateNavigationButtons()
    }
    
    private func updateNavigationButtons() {
        backButtonItem.isEnabled = webView.canGoBack
        forwardButtonItem.isEnabled = webView.canGoForward
        refreshButtonItem.isEnabled = webView.url != nil
    }
    
}

// MARK: - Extensions

extension InternetsViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        updateNavigationButtons()
    }
    
}
