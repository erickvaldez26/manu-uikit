//
//  MNTabBarController.swift
//  manu
//
//  Created by Erick Valdez on 29/04/25.
//

import UIKit

final class MNTabBarController: UIViewController {
    
    private let tabBar = MNTabBar()
    private let container = UIView()
    private var currentViewController: UIViewController?
    var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTabBar()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -50),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBar)
        NSLayoutConstraint.activate([
            tabBar.heightAnchor.constraint(equalToConstant: 62),
            tabBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tabBar.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28)
        ])
    }
    
    private func setupTabBar() {
        tabBar.onTabSelected = { [weak self] index in
            self?.switchToViewController(at: index)
        }
    }
    
    func setViewControllers(_ controllers: [UIViewController]) {
        self.viewControllers = controllers
        switchToViewController(at: 0)
    }
    
    private func switchToViewController(at index: Int) {
        guard index < viewControllers.count else { return }
        
        let selectedVC = viewControllers[index]
        
        currentViewController?.willMove(toParent: nil)
        currentViewController?.view.removeFromSuperview()
        currentViewController?.removeFromParent()
        
        addChild(selectedVC)
        container.addSubview(selectedVC.view)
        selectedVC.view.frame = container.bounds
        selectedVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        selectedVC.didMove(toParent: self)
        
        currentViewController = selectedVC
    }
    
}
