//
//  CollectionViewCompatible.swift
//  iWeather
//
//  Created by 1234 on 17.02.2024.
//

import Foundation
import UIKit

// swiftlint:disable line_length
/**
 Let your model object conform to this protocol to make it compatible with a `UITableView`
 */
public protocol CollectionViewCompatible: CollectionAndTableViewCompatible {
    
    /// Call this from your `UICollectionViewDataSource` and return a fully configured `UICollectionViewCell`. If your cells conforms to the `Configurable` protocol, you can call `configureWithModel(_: T)` with `self` as parameter in your implementation.
    /// parameter tableView: a table view requesting the cell.
    /// parameter indexPath: an index path locating the row in the table view.
    func cellForCollectionView(collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> UICollectionViewCell
    
    var sizeCell: CGSize { get }
}
