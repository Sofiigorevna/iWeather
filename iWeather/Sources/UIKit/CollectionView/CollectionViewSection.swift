//
//  CollectionViewSection.swift
//  iWeather
//
//  Created by 1234 on 17.02.2024.
//

import UIKit

public protocol CollectionViewSection {
    var headerItem: CollectionViewSectionHeaderCompatible? { get set }
    var footerItem: CollectionViewSectionFooterCompatible? { get set }
    var items: [CollectionViewCompatible] { get set }
}
