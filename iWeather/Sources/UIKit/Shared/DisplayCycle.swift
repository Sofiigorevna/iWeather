//
//  DisplayCycle.swift
//  iWeather
//
//  Created by 1234 on 17.02.2024.
//

import UIKit

public protocol DisplayCycle {
    
    func willDisplay()
    
    func didEndDisplay()
    
}

@objc
extension UITableViewCell: DisplayCycle {

    public func willDisplay() { }
    
    public func didEndDisplay() { }
    
}

@objc
extension UICollectionViewCell: DisplayCycle {
    
    public func willDisplay() { }
    
    public func didEndDisplay() { }
    
}
