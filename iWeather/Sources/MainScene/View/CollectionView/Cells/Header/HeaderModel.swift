//
//  HeaderModel.swift
//  iWeather
//
//  Created by 1234 on 18.02.2024.
//

import UIKit

class HeaderModel: CollectionViewSectionHeaderCompatible {
    
    let title: String
    
    init(
        title: String
    ) {
        self.title = title
    }
    
    var headerSize: CGSize {
        .zero
    }
    
    var reuseIdentifier: String {
        String(describing: Header.self)
    }
    
    func headerForCollectionView(
        collectionView: UICollectionView,
        atIndexPath indexPath: IndexPath
    ) -> UICollectionReusableView? {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        ) as? Header else {
            return nil
        }
        
        header.configure(with: self)
        return header
    }
}
