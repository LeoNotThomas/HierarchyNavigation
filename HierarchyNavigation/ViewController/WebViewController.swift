//
//  ViewController.swift
//  HierarchyNavigation
//
//  Created by Thomas Leonhardt on 29.06.22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private var navigationStack = [UIViewController]()
    private var navigation: Navigation?
    private var webView: WKWebView!
    private var url: URL! {
        didSet {
            activity.startAnimating()
            loadContent()
        }
    }
    
    private var activity: UIActivityIndicatorView! {
        didSet {
            activity.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        activity = UIActivityIndicatorView(style: .medium)
        view.addSubview(activity)
        activity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        NavigationLoader().excecute()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.navigationLoadDidFinish, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.toyLinkSelected, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.categoryStack, object: nil)
    }
    
    private func loadContent() {
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = false
    }

    private func setup() {
        url = URL(string: "https://www.mytoys.de")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.menuItem(target: self, action: #selector(openMenu))
        NotificationCenter.default.addObserver(self, selector: #selector(navigationLoadDidFinish(notification:)), name: Notification.navigationLoadDidFinish, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(newLinkRecived(notification:)), name: Notification.toyLinkSelected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stackRecived(notification:)), name: Notification.categoryStack, object: nil)
    }
    
    @objc
    private func openMenu() {
        if let navigation = navigation {
            if navigationStack.isEmpty {
                let viewModel = NavigationViewModel(navigation: navigation)
                let categoryViewController = CategoryViewController.instatiateFromStoryBoard(viewModel: viewModel)
                navigationStack = [categoryViewController]
            }
            let navigationController = UINavigationController()
            navigationController.viewControllers = navigationStack
            self.present(navigationController, animated: true)
        }
    }
    
    @objc
    func navigationLoadDidFinish(notification: Notification) {
        navigation = notification.userInfo?[Constant.UserInfoKey.navigation] as? Navigation
    }
    
    @objc
    func newLinkRecived(notification: Notification) {
        if let url = URL(string: notification.userInfo?[Constant.UserInfoKey.toyLink] as! String) {
            self.url = url
        }
    }
    
    @objc
    func stackRecived(notification: Notification) {
        if let viewControllers = notification.userInfo![Constant.UserInfoKey.navigationStack] as? [UIViewController] {
            navigationStack = viewControllers
        }
    }
}

extension WebViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
        activity.isHidden = true
    }
}

