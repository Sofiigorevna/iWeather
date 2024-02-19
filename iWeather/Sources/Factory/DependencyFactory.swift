//
//  DependencyFactory.swift
//  iWeather
//
//  Created by 1234 on 17.02.2024.
//

import UIKit

protocol Factory {
    func makeWeatherViewController() -> UIViewController
    func makeMenuViewController() -> UIViewController
    func makeAccountViewController() -> UIViewController
}

class DependencyFactory: Factory {
    static let shared = DependencyFactory()

    func makeWeatherViewController() -> UIViewController {
        let viewController = WeatherViewController()
        let networkService = NetworkManager()
        let presenter = MainPresenter(view: viewController, networkService: networkService)
        viewController.mainPresenter = presenter
        return viewController
    }
    
    func makeMenuViewController() -> UIViewController {
        let viewController = MenuViewController()
        let presenter = MenuPresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }

    func makeAccountViewController() -> UIViewController {
        let viewController = AccountViewController()
        let presenter = AccountPresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }
}

