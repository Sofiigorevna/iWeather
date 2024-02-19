//
//  MenuPresenter.swift
//  iWeather
//
//  Created by 1234 on 17.02.2024.
//

import Foundation
class MenuPresenter: PresenterType {
     private var view: ViewControllerProtocol?
        
    init(
        view: ViewControllerProtocol
    ) {
        self.view = view
    }
}
