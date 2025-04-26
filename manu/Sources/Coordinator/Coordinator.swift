//
//  Coordinator.swift
//  manu
//
//  Created by Erick Valdez on 25/04/25.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
