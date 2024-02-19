//
//  AccountPresenter.swift
//  iWeather
//
//  Created by 1234 on 17.02.2024.
//

import Foundation

protocol PresenterType {
}

class AccountPresenter: PresenterType {
    private var view: (ViewControllerProtocol)?
    
    init(
        view: ViewControllerProtocol
    ) {
        self.view = view
    }
}
