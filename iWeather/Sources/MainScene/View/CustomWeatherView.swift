//
//  CustomWeatherView.swift
//  iWeather
//
//  Created by 1234 on 12.02.2024.
//

import UIKit
import SwifterSwift

class CustomWeatherView: UIView {
    
    var buttonTapCompletion: (()-> Void)?
    
    var menuButtonTapCompletion: (()-> Void)?
    
    
    // MARK: - Outlets
    
    private lazy var todayIsDate: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 13)
        label.numberOfLines =  1
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var minTemp: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 13)
        label.numberOfLines =  2
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var maxTemp: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 13)
        label.numberOfLines =  2
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cityName: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 28)
        label.numberOfLines =  2
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherDegree: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 36)
        label.numberOfLines =  2
        label.textAlignment = .right
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherParameter: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 21)
        label.numberOfLines =  2
        label.textAlignment = .right
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackMinMaxTemp: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            minTemp,
            maxTemp
        ])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.setCustomSpacing(0, after: minTemp)
        stack.setCustomSpacing(0, after: maxTemp)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var stackTodayIsDate: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            todayIsDate,
            stackMinMaxTemp
        ])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.setCustomSpacing(0, after: todayIsDate )
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var stackCityAndDate: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cityName,
                                                   stackTodayIsDate,
                                                   
                                                  ])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.setCustomSpacing(0, after: cityName)
        stack.setCustomSpacing(0, after: stackTodayIsDate)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var stackDegree: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [weatherDegree,
                                                   weatherParameter
                                                  ])
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.distribution = .fillEqually
        stack.setCustomSpacing(1, after: weatherDegree)
        stack.setCustomSpacing(5, after: weatherParameter)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var stackGeneral: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [stackCityAndDate,
                                                   stackDegree
                                                  ])
        stack.axis = .horizontal
        stack.setCustomSpacing(1, after: stackCityAndDate)
        stack.setCustomSpacing(5, after: stackDegree)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var labelSwipeDown: UILabel = {
        var label = UILabel()
        label.text = "Swipe down for details"
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        label.numberOfLines =  1
        label.textAlignment = .right
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var swipeDownButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Vector 9"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var accountButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "account 1"), for: .normal)
        button.addTarget(self, action: #selector(accountButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "menu"), for: .normal)
        button.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "main")
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error in Cell")
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        self.addSubview(imageView)
        self.add(
            stackGeneral,
            labelSwipeDown,
            swipeDownButton,
            accountButton,
            menuButton
        )
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            
            stackGeneral.topAnchor.constraint(equalTo: topAnchor, constant: 163),
            stackGeneral.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
            stackGeneral.rightAnchor.constraint(equalTo: rightAnchor, constant: -25),
            
            stackTodayIsDate.widthAnchor.constraint(equalToConstant: 155),
            
            
            labelSwipeDown.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            labelSwipeDown.leftAnchor.constraint(equalTo: leftAnchor, constant: 146),
            labelSwipeDown.widthAnchor.constraint(equalToConstant: 122),
            labelSwipeDown.heightAnchor.constraint(equalToConstant: 14),
            
            swipeDownButton.heightAnchor.constraint(equalToConstant: 10),
            swipeDownButton.widthAnchor.constraint(equalToConstant: 20),
            swipeDownButton.topAnchor.constraint(equalTo: labelSwipeDown.bottomAnchor, constant: 9),
            swipeDownButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 197),
            
            accountButton.heightAnchor.constraint(equalToConstant: 34),
            accountButton.widthAnchor.constraint(equalToConstant: 34),
            accountButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
            accountButton.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            
            menuButton.heightAnchor.constraint(equalToConstant: 18),
            menuButton.widthAnchor.constraint(equalToConstant: 34),
            menuButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -27),
            menuButton.topAnchor.constraint(equalTo: topAnchor, constant: 58),
        ])
    }
    
    // скруглить только низ
    func setCorners(_ corners: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = corners
        self.layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
    }
    
    // MARK: - Configuration
    
    func configureView(with weather: Weather) {
        cityName.text = "\(weather.locality)"
        weatherDegree.text = "\(weather.temperatureString)"
        weatherParameter.text = "\(weather.conditionTranslate)"
        minTemp.text = "\(weather.tempMinString)"
        maxTemp.text = "/ \(weather.tempMaxString)"
        todayIsDate.text = weather.dateString
        
    }
    
    // MARK: - Actions
    
    @objc private func accountButtonAction() {
        buttonTapCompletion?()
    }
    
    @objc private func menuButtonAction() {
        menuButtonTapCompletion?()
    }
}




