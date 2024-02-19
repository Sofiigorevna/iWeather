//
//  CollectionViewDataSource.swift
//  iWeather
//
//  Created by 1234 on 17.02.2024.
//

import UIKit

open class CollectionViewDataSource: NSObject, CollectionViewData, UICollectionViewDataSource {

    public let collectionView: UICollectionView
    open var sections: [CollectionViewSection] = []
    
    public init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        collectionView.dataSource = self
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       numberOfRowsInSection(section: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellForCollectionView(collectionView: collectionView, atIndexPath: indexPath)
    }
    
    // Optional
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        numberOfSections()
    }
    
    open func insertItem(atIndexPath indexPath: IndexPath) {
        // Override in subclass if needed
    }
    
    open func deleteItem(atIndexPath indexPath: IndexPath) {
        self.sections[indexPath.section].items.remove(at: indexPath.row)
    }
    
}
