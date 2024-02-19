//
//  LineTextCollectionViewCellModel.swift
//  iWeather
//
//  Created by 1234 on 18.02.2024.
//

import UIKit

class LineTextCollectionViewCellModel: CollectionViewCompatible {
    
    let title: String
    
    init(
        title: String
    ) {
        self.title = title
    }
    
    var sizeCell: CGSize {
        .zero
    }
    
    var reuseIdentifier: String {
        String(describing: LineTextCollectionViewCell.self)
    }
    
    func cellForCollectionView(collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: self.reuseIdentifier,
            for: indexPath
        ) as? LineTextCollectionViewCell else {
            return UICollectionViewCell()
        }
     
        cell.configure(with: self)
        return cell
    }
}
