//
//  CollectionViewData.swift
//  iWeather
//
//  Created by 1234 on 17.02.2024.
//

import UIKit

public protocol CollectionViewData {
    
    var sections: [CollectionViewSection] { get set }
    
    subscript(indexPath: IndexPath) -> CollectionViewCompatible { get set }
    
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func cellForCollectionView(collectionView: UICollectionView, atIndexPath: IndexPath) -> UICollectionViewCell
    func headerForCollectionView(collectionView: UICollectionView,
                                 atIndexPath indexPath: IndexPath) -> UICollectionReusableView?
    func footerForCollectionView(collectionView: UICollectionView,
                                 atIndexPath indexPath: IndexPath) -> UICollectionReusableView?
    
}

// Default implementations
public extension CollectionViewData {
    
    subscript(indexPath: IndexPath) -> CollectionViewCompatible {
        get {
            sections[indexPath.section].items[indexPath.row]
        }
        set {
            var items = sections[indexPath.section].items
            items.insert(newValue, at: indexPath.row)
        }
    }
    
    func numberOfSections() -> Int {
        sections.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if let header = sections[section].headerItem {
            return header.isCollapsed ? 0 : sections[section].items.count
        }
        return sections[section].items.count
    }
    
    func cellForCollectionView(
        collectionView: UICollectionView,
        atIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let model = self[indexPath]
        return model.cellForCollectionView(collectionView: collectionView, atIndexPath: indexPath)
    }
    
    func headerForCollectionView(collectionView: UICollectionView,
                                 atIndexPath indexPath: IndexPath) -> UICollectionReusableView? {
        sections[indexPath.section].headerItem?.headerForCollectionView(
            collectionView: collectionView,
            atIndexPath: indexPath
        )
    }
    
    func footerForCollectionView(
        collectionView: UICollectionView,
        atIndexPath indexPath: IndexPath
    ) -> UICollectionReusableView? {
        sections[indexPath.section].footerItem?.footerForCollectionView(
            collectionView: collectionView,
            atIndexPath: indexPath
        )
    }
}

