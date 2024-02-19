//
//  CityCollectionSection.swift
//  iWeather
//
//  Created by 1234 on 18.02.2024.
//

// Описание наших секций
class CityCollectionSection: CollectionViewSection {
    var headerItem: CollectionViewSectionHeaderCompatible?
    var footerItem: CollectionViewSectionFooterCompatible?
    var items: [CollectionViewCompatible]

    init(
        headerItem: CollectionViewSectionHeaderCompatible,
        items: [CollectionViewCompatible]
    ) {
        self.headerItem = headerItem
        self.items = items
    }
}
