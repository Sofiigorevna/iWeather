//
//  AccountViewController.swift
//  iWeather
//
//  Created by 1234 on 16.02.2024.
//

import UIKit

final class AccountViewController: UIViewController, ViewControllerProtocol {
    
    // MARK: - State
    
    var presenter: PresenterType?
    
    // MARK: - Outlets

    private lazy var labelHello: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 21)
        label.text = "Hello World"
        label.textAlignment = .center
        label.textColor = .systemIndigo
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.customBackgroundColor
        view.add(labelHello)
        setupLayout()
    }
    
    // MARK: - Setup
    private func setupLayout() {
        NSLayoutConstraint.activate([
            labelHello.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelHello.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
