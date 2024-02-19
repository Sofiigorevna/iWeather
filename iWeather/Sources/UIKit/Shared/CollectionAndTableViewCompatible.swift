//
//  CollectionAndTableViewCompatible.swift
//  iWeather
//
//  Created by 1234 on 17.02.2024.
//

import Foundation

public protocol CollectionAndTableViewCompatible {
    
    var reuseIdentifier: String { get }
    
    var editable: Bool { get }
    var movable: Bool { get }
    
    func prefetch()
    func cancelPrefetch()
}

// Default implementations
public extension CollectionAndTableViewCompatible {
    
    var editable: Bool {
        false
    }
    
    var movable: Bool {
        false
    }
    
    func prefetch() { }
    func cancelPrefetch() { }
}
