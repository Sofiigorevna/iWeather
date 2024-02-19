//
//  MainPresenter.swift
//  iWeather
//
//  Created by 1234 on 17.02.2024.
//

import UIKit

protocol MainPresenterType {
    var weathersArray: [Weather] {get set}
    var weatherMini: [Hour] {get}
    var imageBackground: [CellBackground] { get }
    func performNetworking(
        lat: String,
        lon: String
    )
    
    func prepareInitSetup()
    
    func didSelectedCity(with: Int)
    
    func prepareWeatherMini(with: Int)
    
    func countHours() -> [Int]
}

class MainPresenter: MainPresenterType {
    
    weak private var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol?
    
    var weatherMini = [Hour]()
    var weathersArray = [Weather]()
    var imageBackground = CellBackground.allImages
    
    let group = DispatchGroup()
    
    var locations = [
        (lat: "55.75396", lon: "37.620393"),
        (lat:"44.497415", lon: "34.169506"),
        (lat: "59.938678", lon: "30.314474"),
        (lat:"59.565195", lon: "150.806375"),
        (lat:"55.796127", lon: "49.106414"),
        (lat:"56.326797", lon: "44.006516"),
        (lat:"47.222078", lon: "39.720358"),
        (lat:"56.484645", lon: "84.947649"),
        (lat:"58.010455", lon: "56.229443"),
        (lat:"45.035470", lon: "38.975313"),
    ]
    
    init(
        view: MainViewProtocol,
        networkService: NetworkServiceProtocol
    ) {
        self.view = view
        self.networkService = networkService
    }
    
    func prepareInitSetup() {
        fetchAll()
        group.notify(queue: .main) { [weak self] in
            guard let strongSelf = self,
                  let firstCity = strongSelf.weathersArray.first else {
                return
            }
            
            strongSelf.view?.prepareData(
                with: strongSelf.weathersArray,
                weatherMini: strongSelf.weatherMini,
                currentTime: strongSelf.countHours()
            )
            strongSelf.view?.prepareInitViews(with: firstCity)
            strongSelf.view?.success()
        }
    }
    
    /// Была перезагружена секция с мини погодой
    
    func prepareWeatherMini(with item: Int) {
        guard item < weathersArray.count else {
            return
        }
        
        let filteredHours = filterCountHours(weathersArray[item].hours)
        
        view?.prepareDataForWeatherMini(
            with: weathersArray,
            weatherMini: filteredHours,
            currentTime: self.countHours()
        )
    }
    
    /// Была нажата ячейка города
    
    func didSelectedCity(with item: Int) {
        guard item < weathersArray.count else {
            return
        }
        
        view?.prepareInitViews(
            with: weathersArray[item]
        )
    }
    
    private func filterCountHours(
        _ array: [Hour]
    ) -> [Hour] {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: currentDate)
        
        return array.filter({ hour in
            return  Int(hour.hour) == currentHour || Int(hour.hour) ?? 0 > currentHour
        })
    }
    
    func fetchAll() {
        for location in locations {
            performNetworking(lat: location.lat, lon: location.lon)
        }
    }
    
    func performNetworking(
        lat: String,
        lon: String
    ) {
        group.enter()
        NetworkManager.sharedInstance.fetchAPIData(
            lat: lat,
            lon: lon
        ) { [weak self] weather in
            guard let self = self else {
                return
            }
            
            self.weathersArray.append(weather)
            
            let firstElement = self.weathersArray.first?.hours
            
            if let data = firstElement {
                self.weatherMini = self.filterCountHours(data)
            }
            self.group.leave()
        }
    }
    
    func countHours() -> [Int] {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: currentDate)
        
        let hoursToShow = Array(currentHour..<24)
        return hoursToShow
    }
}

