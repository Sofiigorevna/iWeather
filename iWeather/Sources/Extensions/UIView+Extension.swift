//
//  UIView+Extension.swift
//  iWeather
//
//  Created by 1234 on 12.02.2024.
//

import UIKit

extension UIView {
    /// Рекурсивно вытаскивает все subviews
    var allSubviews: [UIView] {
        subviews.flatMap { [$0] + $0.allSubviews }
    }
    
    // swiftlint:disable force_cast
    class func fromNib<T: UIView>() -> T {
        Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

extension UIView {
    func add(_ views: UIView...) {
        for v in views {
            self.addSubview(v)
        }
    }

    public func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    func updateConstraint(_ attribute: NSLayoutConstraint.Attribute, to constant: CGFloat) {
        for constraint in constraints where constraint.firstAttribute == attribute {
            constraint.constant = constant
        }
    }
}
