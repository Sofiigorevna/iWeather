//
//  ViewController.swift
//  iWeather
//
//  Created by 1234 on 11.02.2024.
//
import UIKit

final class WeatherViewController: UIViewController {
    
    // MARK: - State
    
    var locations = [
        (lat: "55.75396", lon: "37.620393"),
        (lat:"44.497415", lon: "34.169506"),
        (lat: "59.938678", lon: "30.314474"),
        (lat:"59.565195", lon: "150.806375"),
        (lat:"55.796127", lon: "49.106414"),
        (lat:"56.326797", lon: "44.006516"),
        (lat:"47.222078", lon: "39.720358"),
        (lat:"56.484645", lon: "84.947649"),
        (lat:"58.010455", lon: "56.229443"),
        (lat:"45.035470", lon: "38.975313"),
    ]
    var weatherMini = [Hour]()
    var weathersArray = [Weather]()
    let group = DispatchGroup()
    
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
        let layout = createLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CityCell.self,
                                forCellWithReuseIdentifier: CityCell.identifier)
        collectionView.register(WeatherCell.self,
                                forCellWithReuseIdentifier: WeatherCell.identifier)
        collectionView.register(Header.self,
                                forSupplementaryViewOfKind:
                                    UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier:
                                    Header.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "purpurColor")
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        
        for location in locations {
            performNetworking(lat: location.lat, lon: location.lon)
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let strongSelf = self,
                  let firstCity = strongSelf.weathersArray.first else {
                return
            }
            strongSelf.prepareInitViews(with: firstCity)
            strongSelf.collectionView.reloadData()
        }
    }
    
    private func prepareInitViews(with weather: Weather) {
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
    
    func performNetworking(
        lat: String,
        lon: String
    ) {
        group.enter()
        APIFetchHandler.sharedInstance.fetchAPIData(
            lat: lat,
            lon: lon
        ) { [weak self] weather in
            guard let self = self else {
                return
            }
            
            self.weathersArray.append(weather)
            
            let firstElement = self.weathersArray.first?.hours
            
            if let data = firstElement {
                self.weatherMini = self.filterCountHours(data)
            }
            
            self.group.leave()
        }
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
            return UIHelper.createCollectionLayoutSection(section)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension WeatherViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        
        switch section {
        case 0:
            return weathersArray.count
        case 1:
            return weatherMini.count
            
        default: fatalError("SECTION ERROR ------------> UIViewController")
            
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CityCell.identifier,
                for: indexPath
            ) as? CityCell else {
                return UICollectionViewCell()
            }
            
            cell.configurationBackground(model: CellBackground.allImages[indexPath.row])
            
            let weather = weathersArray[indexPath.row]
            cell.configuration(weather: weather)
            
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier:
                    WeatherCell.identifier, for: indexPath) as? WeatherCell else {
                return UICollectionViewCell()
            }
            
            let hoursToShow = countHours()
            let hoursStrings = hoursToShow.map {
                formatToTime($0)
            }
            
            let hourToShow = hoursStrings[indexPath.row]
            cell.labelForTime.text = hourToShow
            
            if indexPath.row == 0 {
                cell.labelForTime.text = "Сейчас"
            }
            
            cell.configuration(model: weatherMini[indexPath.row])
            
            return cell
        default:
            fatalError("Layout ERROR ------------> UIViewController")
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.identifier, for: indexPath) as! Header
        header.title.text = "Today"
        return header
    }
}

// MARK: - UICollectionViewDelegate

extension WeatherViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        
        let cellWeatherMini = collectionView.dequeueReusableCell(
            withReuseIdentifier:
                WeatherCell.identifier, for: indexPath) as? WeatherCell
        
        if indexPath.section == 0 {
            
            let selectedData = weathersArray[indexPath.row]
            
            prepareInitViews(with: selectedData)
            
            // new data for cell second section
            let forCell = selectedData.hours
            
            let filteredHours = filterCountHours(forCell)
            
//                cellWeatherMini?.configuration(model: filteredHours[indexPath.row])
                collectionView.reloadSections(IndexSet(integer: 1))
        }
    }
}

extension WeatherViewController{
    func formatToTime(_ number: Int) -> String {
        if number < 10 {
            return "0\(number):00"
        } else {
            return "\(number):00"
        }
    }
    
    func countHours() -> [Int] {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: currentDate)
        
        let hoursToShow = Array(currentHour..<24)
        return hoursToShow
    }
    
    func filterCountHours(_ array: [Hour]) -> [Hour] {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: currentDate)
        
        return array.filter({ hour in
            return  Int(hour.hour) == currentHour || Int(hour.hour) ?? 0 > currentHour
        })
    }
}
