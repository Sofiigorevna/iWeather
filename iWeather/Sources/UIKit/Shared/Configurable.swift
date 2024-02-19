//
//  Configurable.swift
//  iWeather
//
//  Created by 1234 on 17.02.2024.
//

import Foundation

// swiftlint:disable all
/**
 Let your `UICollectionViewCell` or `UITableViewCell` conform to this protocol.
 */
public protocol Configurable {
    
    associatedtype T
    var model: T? { get set }
    func configure(with model: T)
    
}
