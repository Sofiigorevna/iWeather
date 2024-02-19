//
//  WeatherCollectionViewCell.swift
//  iWeather
//
//  Created by 1234 on 18.02.2024.
//

import UIKit
import SVGKit

class WeatherCollectionViewCell: UICollectionViewCell,
                                 Configurable {

    var model: WeatherCollectionViewCellModel?
    
    // MARK: - Outlets
    
    lazy var labelForTime: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 15)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelForDegree: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Poppins-Medium", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var viewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "lavandaColor")
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconView,
                                                   labelForDegree
                                                  ])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.setCustomSpacing(1, after: iconView)
        stack.setCustomSpacing(5, after: labelForDegree)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let bottomStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundViewColor = UIColor(named: "purpurColor")
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
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
        contentView.addSubview(viewBackground)
        viewBackground.addSubview(stack)
        contentView.addSubview(bottomStack)
        bottomStack.addArrangedSubview(labelForTime)
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            viewBackground.widthAnchor.constraint(equalToConstant: 76),
            viewBackground.heightAnchor.constraint(equalToConstant: 76),
            viewBackground.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            viewBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            
            iconView.heightAnchor.constraint(equalToConstant: 30),
            iconView.widthAnchor.constraint(equalToConstant: 30),
                        
            stack.centerXAnchor.constraint(equalTo: viewBackground.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: viewBackground.centerYAnchor),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stack.widthAnchor.constraint(equalToConstant: 47),
            
            bottomStack.topAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: 5),
            bottomStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bottomStack.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // MARK: - Configuration
    
    func configure(with model: WeatherCollectionViewCellModel) {
        self.model = model
        
        configuration(model: model.hour)
    }
    
    func configuration(model: Hour) {
        
        self.labelForDegree.text = "\(model.temp)" + "ºC"

        let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/?\(model.icon).svg")
        guard let url = url else {
            return
        }
        
        NetworkManager.sharedInstance.loadSVGImage(from: url) { [weak self] image in
            guard let self = self else {
                return
            }
            
            if let svgImage = image {
                DispatchQueue.main.async {
                    self.iconView.image = svgImage
                }
            } else {
                print("Failed to load SVG image")
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.iconView.image = nil
    }
}



