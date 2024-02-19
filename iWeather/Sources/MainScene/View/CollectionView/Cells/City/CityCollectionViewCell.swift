//
//  CityCollectionViewCell.swift
//  iWeather
//
//  Created by 1234 on 18.02.2024.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell,
                              Configurable {
    
    var model: CityCollectionViewCellModel?
    
    // MARK: - Outlets
    
    private lazy var imageView: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var viewContainer: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public lazy var cityName: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 20)
        label.numberOfLines =  3
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherDegree: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 18)
        label.numberOfLines =  1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cityHStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cityName,
                                                   weatherDegree
                                                  ])
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.setCustomSpacing(1, after: cityName)
        stack.setCustomSpacing(2, after: weatherDegree)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        contentView.addSubview(imageView)
        imageView.addSubview(cityHStackView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            cityHStackView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            cityHStackView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 22),
            cityHStackView.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 13)
        ])
    }
    
    // MARK: - Configuration
    
    func configure(
        with model: CityCollectionViewCellModel
    ) {
        self.model = model
        
        cityName.text = model.name
        weatherDegree.text = model.degree
    }
    
    func configurationBackground(model: CellBackground) {
        self.imageView.image = UIImage(named: model.image)
    }
}

