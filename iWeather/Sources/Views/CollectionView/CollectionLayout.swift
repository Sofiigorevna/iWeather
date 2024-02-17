//
//  CollectionLayout.swift
//  iWeather
//
//  Created by 1234 on 15.02.2024.
//

import UIKit

struct UIHelper {

    static func createCollectionLayoutSection(_ section: Int ) -> NSCollectionLayoutSection {
        switch section {
        case 0:
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(
                layoutSize: itemSize
            )
            item.contentInsets = .init(
                top: 0,
                leading: 8,
                bottom: 0,
                trailing: 8
            )
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(0.5)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            
            group.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 10,
                bottom: 10,
                trailing: 10
            )
            
            let section = NSCollectionLayoutSection(
                group: group
            )
            
            section.orthogonalScrollingBehavior = .groupPaging
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 12, leading: 4, bottom: 16, trailing: 4
            )
            return section
            
        case 1:
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
            
            let layoutItem = NSCollectionLayoutItem(
                layoutSize: itemSize
            )
            layoutItem.contentInsets = .init(
                top: 0,
                leading: 8,
                bottom: 0,
                trailing: 8
            )
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.237),
                heightDimension: .fractionalHeight(0.4))

            let layoutGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [layoutItem]
            )
            
            layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0)
            
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            
            layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 0)
            
            layoutSection.orthogonalScrollingBehavior = .groupPaging
            
            // Header
            let layoutSectionHeaderSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.96),
                heightDimension: .fractionalWidth(0.09)
            )
            let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: layoutSectionHeaderSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            
            layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
            
            return layoutSection
            
        default: fatalError("Layout ERROR ------------> UIViewController")
        }
    }
}
