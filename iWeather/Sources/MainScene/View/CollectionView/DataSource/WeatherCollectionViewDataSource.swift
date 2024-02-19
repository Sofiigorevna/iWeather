//
//  WeatherCollectionViewDataSource.swift
//  iWeather
//
//  Created by 1234 on 17.02.2024.
//

import UIKit

class WeatherCollectionViewDataSource: CollectionViewDataSource {
    
    override init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView)
        registerCell()
    }
    
    func prepareData(
        with weather: [Weather],
        weatherMini: [Hour],
        currentTime: [Int]
    ) {
        
        let section: [CollectionViewSection] = CollectionViewItems.allCases.map {
            switch $0 {
            case .cities:
                let headerItem = HeaderModel(
                    title: ""
                )
                
                let cityItem = weather.map { value in
                    CityCollectionViewCellModel(
                        name: value.locality,
                        degree: value.temperatureString
                    )
                }
                
                let citySections = CityCollectionSection(
                    headerItem: headerItem,
                    items: cityItem
                )
                return citySections
            case .titleWeather:
                let titleWeatherItem = LineTextCollectionViewCellModel(
                    title: "Today"
                )
                
                let lineTextSections = LineTextCollectionViewSection(
                    items: [titleWeatherItem]
                )
                return lineTextSections
            case .weatherInfo:
                let headerItem = HeaderModel(
                    title: ""
                )
                
                let weatherItem = weatherMini.map { value in
                    WeatherCollectionViewCellModel(
                        hour: value,
                        currentTime: currentTime
                    )
                }
                
                let weatherSections = WeatherMiniCollectionViewSection(
                    headerItem: headerItem,
                    items: weatherItem
                )
                
                return weatherSections
            }
        }
        self.sections = section
        
        //         Перезагружаем
            self.collectionView.reloadData()
    }
    
    func prepareDataForWeatherMini(
        with weather: [Weather],
        weatherMini: [Hour],
        currentTime: [Int]
    ) {
        
        let section: [CollectionViewSection] = CollectionViewItems.allCases.map {
            switch $0 {
            case .cities:
                let headerItem = HeaderModel(
                    title: ""
                )
                
                let cityItem = weather.map { value in
                    CityCollectionViewCellModel(
                        name: value.locality,
                        degree: value.temperatureString
                    )
                }
                
                let citySections = CityCollectionSection(
                    headerItem: headerItem,
                    items: cityItem
                )
                return citySections
            case .titleWeather:
                let titleWeatherItem = LineTextCollectionViewCellModel(
                    title: "Today"
                )
                
                let lineTextSections = LineTextCollectionViewSection(
                    items: [titleWeatherItem]
                )
                return lineTextSections
            case .weatherInfo:
                let headerItem = HeaderModel(
                    title: ""
                )
                
                let weatherItem = weatherMini.map { value in
                    WeatherCollectionViewCellModel(
                        hour: value,
                        currentTime: currentTime
                    )
                }
                
                let weatherSections = WeatherMiniCollectionViewSection(
                    headerItem: headerItem,
                    items: weatherItem
                )
                
                return weatherSections
            }
        }
        self.sections = section
        
        //         Перезагружаем
        let weatherMiniSection = CollectionViewItems.weatherInfo.rawValue
                
        UIView.animate(withDuration: 0.3) {
            self.collectionView.reloadSections(
                .init(integer: weatherMiniSection)
            )
        }
    }
}
/**
 Регистрируем классы ячеек
 */
private
extension WeatherCollectionViewDataSource {
    func registerCell() {
        // Ячейка с погодой в картинках
        collectionView.register(
            cellWithClass: CityCollectionViewCell.self
        )
        collectionView.register(
            cellWithClass: WeatherCollectionViewCell.self
        )
        collectionView.register(
            cellWithClass: LineTextCollectionViewCell.self
        )
    }
}
