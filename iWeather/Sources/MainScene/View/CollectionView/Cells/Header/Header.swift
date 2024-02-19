//
//  Header.swift
//  iWeather
//
//  Created by 1234 on 12.02.2024.
//

import UIKit

class Header: UICollectionReusableView,
              Configurable {
    
    var model: HeaderModel?
    
    // MARK: - Outlets
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Poppins-Regular", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubview(title)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            title.bottomAnchor.constraint(equalTo:  bottomAnchor),
            title.leftAnchor.constraint(equalTo: leftAnchor),
            title.rightAnchor.constraint(equalTo: rightAnchor),
            title.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
    
    func configure(with model: HeaderModel) {
        self.model = model
        
        title.text = model.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
    }
}
