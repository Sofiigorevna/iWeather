//
//  WeatherCollectionViewCellModel.swift
//  iWeather
//
//  Created by 1234 on 18.02.2024.
//

import UIKit

class WeatherCollectionViewCellModel: CollectionViewCompatible {
    
    let hour: Hour
    let currentTime: [Int]
    
    init(
        hour: Hour,
        currentTime: [Int]
    ) {
        self.hour = hour
        self.currentTime = currentTime
    }
    
    var sizeCell: CGSize {
        .zero
    }
    
    var reuseIdentifier: String {
        String(describing: WeatherCollectionViewCell.self)
    }
    
    func formatToTime(_ number: Int) -> String {
        if number < 10 {
            return "0\(number):00"
        } else {
            return "\(number):00"
        }
    }
    
    func cellForCollectionView(
        collectionView: UICollectionView,
        atIndexPath indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: self.reuseIdentifier,
            for: indexPath
        ) as? WeatherCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let hoursStrings = currentTime.map {
            self.formatToTime($0)
        }
        
        cell.labelForTime.text = hoursStrings[safe: indexPath.row]
        cell.configure(with: self)
        
        if indexPath.row == 0 {
            cell.labelForTime.text = "Сейчас"
        }
        
        return cell
    }
}
