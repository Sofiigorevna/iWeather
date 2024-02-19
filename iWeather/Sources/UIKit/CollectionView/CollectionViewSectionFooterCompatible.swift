//
//  CollectionViewSectionFooterCompatible.swift
//  iWeather
//
//  Created by 1234 on 17.02.2024.
//

import UIKit

public protocol CollectionViewSectionFooterCompatible {
    
    var reuseIdentifier: String { get }
    
    func footerForCollectionView(collectionView: UICollectionView,
                                 atIndexPath indexPath: IndexPath) -> UICollectionReusableView?
}
