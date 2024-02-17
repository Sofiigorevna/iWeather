//
//  HeaderChevron.swift
//  iWeather
//
//  Created by 1234 on 14.02.2024.
//

import UIKit

class HeaderChevron: UICollectionReusableView {
    
    static let identifier = "HeaderChevron"
    
    // MARK: - Outlets
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var swipeChevron: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Vector"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error in Cell")
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        addSubview(swipeChevron)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            swipeChevron.heightAnchor.constraint(equalToConstant: 10),
            swipeChevron.widthAnchor.constraint(equalToConstant: 20),
            
//            title.bottomAnchor.constraint(equalTo:  bottomAnchor),
//            title.leftAnchor.constraint(equalTo: leftAnchor),
//            title.rightAnchor.constraint(equalTo: rightAnchor),
//            title.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
    }
}



