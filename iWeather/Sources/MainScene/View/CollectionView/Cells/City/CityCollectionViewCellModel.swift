//
//  CityCollectionViewCellModel.swift
//  iWeather
//
//  Created by 1234 on 18.02.2024.
//

import UIKit

class CityCollectionViewCellModel: CollectionViewCompatible {
    
    let name: String
    let degree: String

    
    init(
        name: String,
        degree: String
    ) {
        self.name = name
        self.degree = degree
    }
    
    var sizeCell: CGSize {
        .zero
    }
    var reuseIdentifier: String {
        String(describing: CityCollectionViewCell.self)
    }
    
    func cellForCollectionView(
        collectionView: UICollectionView,
        atIndexPath indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: self.reuseIdentifier,
            for: indexPath
        ) as? CityCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configurationBackground(
            model: CellBackground.allImages[indexPath.row]
        )
        cell.configure(with: self)
        return cell
    }
}
