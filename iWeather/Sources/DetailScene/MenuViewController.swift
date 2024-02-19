//
//  MenuViewController.swift
//  iWeather
//
//  Created by 1234 on 16.02.2024.
//

import UIKit

protocol ViewControllerProtocol {
    
}
final class MenuViewController: UIViewController, ViewControllerProtocol {
    
    // MARK: - State
    
    var presenter: PresenterType?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
