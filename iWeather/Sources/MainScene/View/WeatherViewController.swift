//
//  ViewController.swift
//  iWeather
//
//  Created by 1234 on 11.02.2024.
//
import UIKit

protocol MainViewProtocol: AnyObject {
    func success()
    
    func prepareInitViews(
        with weather: Weather
    )
    
    func prepareData(
        with: [Weather],
        weatherMini: [Hour],
        currentTime: [Int]
    )
    
    func prepareDataForWeatherMini(
        with weathers: [Weather],
        weatherMini: [Hour],
        currentTime: [Int]
    )
}

final class WeatherViewController: UIViewController {
    
    // MARK: - Dependencies
    
    // Ссылка на датасорс (лэзи потому что отложенная инициализация до обращения к экземпляру)
    private lazy var dataSource = WeatherCollectionViewDataSource(
        collectionView: self.collectionView
    )
    
    // MARK: - State
    
    var mainPresenter: MainPresenterType?
    private let dependencyFactory = DependencyFactory.shared
    
    // MARK: - Outlets
    
    private lazy var weatherView: CustomWeatherView = {
        let view = CustomWeatherView()
        view.backgroundColor = .systemIndigo
        view.clipsToBounds = true
        view.setCorners(30)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: self.setupCollectionViewLayout()
        )
        
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.customBackgroundColor
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupHierarchy()
        setupLayout()
        mainPresenter?.prepareInitSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        pushMenu()
        //       presentAccount()
    }
    
    // MARK: - Setup
    
    private func pushMenu() {
        self.weatherView.menuButtonTapCompletion = { [weak self] in
            self?.pushMenuViewController()
        }
        
    }
    private func presentAccount() {
        self.weatherView.buttonTapCompletion = { [weak self] in
            self?.presentModalViewController()
        }
    }
    
    func presentModalViewController() {
        let viewController = dependencyFactory.makeAccountViewController()
        present(viewController, animated: true)
    }
    
    func pushMenuViewController() {
        let viewController = dependencyFactory.makeMenuViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    internal func prepareInitViews(with weather: Weather) {
        weatherView.configureView(with: weather)
    }
    
    private func setupHierarchy() {
        view.addSubview(weatherView)
        view.addSubview(collectionView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: view.topAnchor),
            weatherView.widthAnchor.constraint(equalToConstant: view.frame.width),
            weatherView.leftAnchor.constraint(equalTo: view.leftAnchor),
            weatherView.heightAnchor.constraint(equalToConstant: 381),
            
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width ),
            collectionView.topAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: 30),
        ])
    }
    
    func prepareData(
        with weathers: [Weather],
        weatherMini: [Hour],
        currentTime: [Int]
    ) {
        dataSource.prepareData(
            with: weathers,
            weatherMini: weatherMini,
            currentTime: currentTime
        )
    }
    
    func prepareDataForWeatherMini(
        with weathers: [Weather],
        weatherMini: [Hour],
        currentTime: [Int]
    ) {
        dataSource.prepareData(
            with: weathers,
            weatherMini: weatherMini,
            currentTime: currentTime
        )
    }
}

// MARK: - UICollectionViewDelegate

extension WeatherViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    )  {
        let moduleSection = CollectionViewItems(
            rawValue: indexPath.section
        )
        
        switch moduleSection {
        case .cities:
            mainPresenter?.didSelectedCity(with: indexPath.item)
            mainPresenter?.prepareWeatherMini(with: indexPath.item)
            
        case .titleWeather:
            debugPrint("titleWeather did tapped")
        case .weatherInfo:
            
            debugPrint("weatherInfo did tapped")
        default:
            break
        }
    }
}

extension WeatherViewController: MainViewProtocol {
    
    func success() {
        self.collectionView.reloadData()
    }
}

extension WeatherViewController {
    private func setupCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            let moduleSection = CollectionViewItems(rawValue: section)
            
            switch moduleSection {
            case .cities:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(
                    layoutSize: itemSize
                )
                item.contentInsets = .init(
                    top: 0,
                    leading: 8,
                    bottom: 0,
                    trailing: 8
                )
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(0.5)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                group.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 10,
                    bottom: 10,
                    trailing: 10
                )
                
                let section = NSCollectionLayoutSection(
                    group: group
                )
                
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: 12, leading: 4, bottom: 16, trailing: 4
                )
                return section
                
            case .titleWeather:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(0.09)
                )
                let item = NSCollectionLayoutItem(
                    layoutSize: itemSize
                )
                item.contentInsets = .init(
                    top: 0,
                    leading: 8,
                    bottom: 0,
                    trailing: 8
                )
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(0.03)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                group.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 10,
                    bottom: 10,
                    trailing: 10
                )
                
                let section = NSCollectionLayoutSection(
                    group: group
                )
                
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: 12, leading: 4, bottom: 16, trailing: 4
                )
                return section
            case .weatherInfo:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
                
                let layoutItem = NSCollectionLayoutItem(
                    layoutSize: itemSize
                )
                layoutItem.contentInsets = .init(
                    top: 0,
                    leading: 8,
                    bottom: 0,
                    trailing: 8
                )
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.237),
                    heightDimension: .fractionalHeight(0.4))
                
                let layoutGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [layoutItem]
                )
                
                layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0)
                
                let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                
                layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 0)
                
                layoutSection.orthogonalScrollingBehavior = .groupPaging
                
                // Header
                let layoutSectionHeaderSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.96),
                    heightDimension: .fractionalWidth(0.01)
                )
                let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: layoutSectionHeaderSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                
                layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
                
                return layoutSection
            default:
                fatalError("Layout ERROR ------------> UIViewController")
            }
        }
        return layout
    }
}
