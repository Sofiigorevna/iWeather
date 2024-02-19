//
//  LineTextCollectionViewSection.swift
//  iWeather
//
//  Created by 1234 on 18.02.2024.
//

// Описание наших секций
class LineTextCollectionViewSection: CollectionViewSection {
    var headerItem: CollectionViewSectionHeaderCompatible?
    var footerItem: CollectionViewSectionFooterCompatible?
    var items: [CollectionViewCompatible]

    init(
        items: [CollectionViewCompatible]
    ) {
        self.items = items
    }
}
