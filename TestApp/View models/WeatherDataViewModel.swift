//
//  WeatherDataViewModel.swift
//  TestApp
//
//  Created by Vanita on 11/8/17.
//  Copyright © 2017 Tixdo. All rights reserved.
//

import Foundation
import ObjectMapper

let weatherAPPID = "52e7832b8a3c01a4d8a56200135d3288"
typealias GetWeatherDataCompletionHandler = () -> Void

protocol WeatherDataViewModelDelegate {
    func weatherDataViewModelFetchedData(_ weatherDataViewModel: WeatherDataViewModel)
}
class WeatherDataViewModel: TestLocationManagerDelegate {
    
    //variables:
    private var weatherData: [WeatherModel] = []
    var selectedIndexPath: IndexPath?
    var locationManager: TestLocationManager = TestLocationManager()
    var delegate: WeatherDataViewModelDelegate?
    
    init() {
        locationManager.setupLocationManager()
        locationManager.testLocationManagerDelegate = self
    }

    //MARK:- tableview set up
    func numberOfRows(in section: Int) -> Int {
        return weatherData.count
    }
    
    func configureCell(cell: UITableViewCell, at indexPath: IndexPath) {
        let weatherDetails = self.weatherData[indexPath.row]
        cell.textLabel?.text = weatherDetails.name
        cell.detailTextLabel?.text = "\(weatherDetails.main?.temp ?? 0) °C"   //show 0 temp for no temp available
    }
    
    //view model for next view:
    func getDetailsViewModelWithData() -> CityWeatherDetailsViewModel {
        let weatherDetails = self.weatherData[(self.selectedIndexPath?.row)!]
        let detailsViewModel = CityWeatherDetailsViewModel(weatherDetails: weatherDetails)
        return detailsViewModel
    }
    
    //MARK:- TestLocationManagerDelegate
    func testLocationManager(_ testLocationManager: TestLocationManager, locationUpdated: Bool) {
        let lat = self.locationManager.lattitude
        let lon = self.locationManager.longitude
        //using max counter for openWeatherAPI (cnt value from 1-50, 50 max)
        getWeatherData(for: "\(lat!)", lon: "\(lon!)", counter: 50) {
            self.delegate?.weatherDataViewModelFetchedData(self)
        }
    }
    
    //MARK:- network calls
    func getWeatherData(for lat: String? = nil, lon: String? = nil, counter: Int, completionHandler: @escaping GetWeatherDataCompletionHandler) {
        var lattitude = lat
        var longitude = lon
        if let lat1 = self.locationManager.lattitude {
            lattitude = "\(lat1)"
        }
        
        if let lon1 = self.locationManager.longitude {
            longitude = "\(lon1)"
        }
        let params = "units=metric&lat=\(lattitude!)&lon=\(longitude!)&cnt=\(counter)&APPID=\(weatherAPPID)"
        let urlStr = "http://api.openweathermap.org/data/2.5/find?" + params
        let netWorkManager = NetworkCallManager()
        netWorkManager.request(request: urlStr, httpMethod: .GET, headers: nil, parameters: nil, netWorkCallManagerCompletionHandler: { [weak self] (data, response, error) in
            //parse t!he json
            if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                if let list = json!["list"] {
                    self?.weatherData = Mapper<WeatherModel>().mapArray(JSONObject: list)!
                }
                completionHandler()
            }
        } )
    }
}
