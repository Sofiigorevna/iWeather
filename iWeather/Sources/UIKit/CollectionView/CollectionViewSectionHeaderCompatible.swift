//
//  CollectionViewSectionHeaderCompatible.swift
//  iWeather
//
//  Created by 1234 on 17.02.2024.
//

import UIKit

public protocol CollectionViewSectionHeaderCompatible {
    
    var reuseIdentifier: String { get }
    
    var headerSize: CGSize { get }
    
    var isCollapsed: Bool { get }
    
    func headerForCollectionView(collectionView: UICollectionView,
                                 atIndexPath indexPath: IndexPath) -> UICollectionReusableView?
    
}

extension CollectionViewSectionHeaderCompatible {
    var isCollapsed: Bool {
        false
    }
}
