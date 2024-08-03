//
//  DetailsViewController.swift
//  ClimaApp
//
//  Created by Diplomado on 03/08/24.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    let weatherModel = WeatherModel()
    let city: City
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = UIColor(hex: "#87CEEB")
        
        return view
    }()
    
    private lazy var showScaleTemp: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["°C", "°F"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(tempScaleChanged), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        return segmentedControl
    }()
    
    private let conditionImageView = UIImageView()
    private let region = UILabel()
    private let temperatureLabel = UILabel()
    private let uvLabel = UILabel()
    private let localTimeLabel = UILabel()
    private let mapView = MKMapView()
    private let lastUpdatedLabel = UILabel()
    
    var dayOrnight: Int = 0
    var colorOfView: String = ""
        
    init(city: City) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Poner el nombre de la ciudad en la de la barra de navegación
        // pero no funciona
        //self.title = city.nombre
        
        weatherModel.getWeather(city: city.nombre) { error in
            if let error = error {
                    print("Error fetching weather data: \(error)")
                } else {
                    if let weather = self.weatherModel.weather {
                        DispatchQueue.main.async {
                            self.setupView(with: weather)
                    }
                }
            }
        }
    }
    
    // Si existe datos del clima se manda a llamar la funcion
    // para hacer el toggle entre uno y otro
    @objc
    private func tempScaleChanged() {
        if let weather = weatherModel.weather {
            updateTemperatureLabel(with: weather)
        }
    }
    
    // Para hacer el toggle entre centrigrados y fahrenheit
    private func updateTemperatureLabel(with weather: WeatherResponse) {
        let temp: String
        if showScaleTemp.selectedSegmentIndex == 0 {
            temp = "\(weather.current.temp_c)°C"
        } else {
            temp = "\(weather.current.temp_f)°F"
        }
        temperatureLabel.text = temp
    }
    
    func setupView(with weather: WeatherResponse) {
        //view.backgroundColor = .green
        //view.backgroundColor = UIColor(hex: "#87CEEB")
        dayOrnight = weather.current.is_day
        colorOfView = dayOrnight == 1 ? "#87CEEB" : "191970"
        
        contentView.backgroundColor = UIColor(hex: colorOfView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let contentViewHeightAnchor = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightAnchor.isActive = true
        contentViewHeightAnchor.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        contentView.addSubview(region)
        contentView.addSubview(showScaleTemp)
        contentView.addSubview(conditionImageView)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(uvLabel)
        contentView.addSubview(localTimeLabel)
        contentView.addSubview(mapView)
        contentView.addSubview(lastUpdatedLabel)
        
        region.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        uvLabel.translatesAutoresizingMaskIntoConstraints = false
        localTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        lastUpdatedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Configuración del UILabel para la región
        NSLayoutConstraint.activate([
            region.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            region.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
        // Configuración del UISegmentedControl
        NSLayoutConstraint.activate([
            showScaleTemp.topAnchor.constraint(equalTo: region.bottomAnchor, constant: 16),
            showScaleTemp.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
        // Configuración icono, temperatura, uv
        NSLayoutConstraint.activate([
            conditionImageView.topAnchor.constraint(equalTo: showScaleTemp.bottomAnchor, constant: 16),
            conditionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            conditionImageView.widthAnchor.constraint(equalToConstant: 64),
            conditionImageView.heightAnchor.constraint(equalToConstant: 64),
            
            temperatureLabel.centerYAnchor.constraint(equalTo: conditionImageView.centerYAnchor),
            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            uvLabel.centerYAnchor.constraint(equalTo: conditionImageView.centerYAnchor),
            uvLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        
        // Configuración de localtime
        NSLayoutConstraint.activate([
            localTimeLabel.topAnchor.constraint(equalTo: conditionImageView.bottomAnchor, constant: 16),
            localTimeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
        // Configuración de MKMapView
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: localTimeLabel.bottomAnchor, constant: 16),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mapView.heightAnchor.constraint(equalToConstant: 200),
        ])
        
        // Configuración de last_updated
        NSLayoutConstraint.activate([
            lastUpdatedLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 16),
            lastUpdatedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            lastUpdatedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
        
        // Actualizar la UI con datos del clima
        region.text = weather.location.region
        loadConditionImage(from: weather.current.condition.icon)
        updateTemperatureLabel(with: weather)
        uvLabel.text = "UV: \(weather.current.uv)"
        localTimeLabel.text = "Local Time: \((weather.location.localtime).replacingOccurrences(of: "-", with: "/"))"
        lastUpdatedLabel.text = "Last Updated: \(weather.current.last_updated)"
        
        // Configuración del mapa
        let location = CLLocationCoordinate2D(latitude: weather.location.lat, longitude: weather.location.lon)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
    }
    
    // Para cargar el iconito del clima de manera asincrona
    private func loadConditionImage(from iconPath: String) {
        let urlString = "https:\(iconPath)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error loading image: \(error)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.conditionImageView.image = image
            }
        }.resume()
    }
}
