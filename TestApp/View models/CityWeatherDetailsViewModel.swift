//
//  CityWeatherDetailsViewModel.swift
//  TestApp
//
//  Created by Vanita on 11/9/17.
//  Copyright © 2017 Tixdo. All rights reserved.
//

import Foundation

class CityWeatherDetailsViewModel {
    private var weatherDetails: WeatherModel?
    
    init(weatherDetails: WeatherModel) {
        self.weatherDetails = weatherDetails
    }
    
    //MARK:- data provider
    func name() -> String {
        guard let name = self.weatherDetails?.name else {
            return ""
        }
        return name
    }
    
    func temprature() -> Float {
        guard let temprature = self.weatherDetails?.main?.temp else {
            return 0
        }
        return temprature
    }
    
    func minTemprature() -> Float {
        guard let minTemprature = self.weatherDetails?.main?.temp_min else {
            return 0
        }
        return  minTemprature
    }
    
    func maxTemprature() -> Float {
        guard let maxTemprature = self.weatherDetails?.main?.temp_max else {
            return 0
        }
        return maxTemprature
    }
    
    func humidity() -> Int {
        guard let humidity = self.weatherDetails?.main?.humidity  else {
            return 0
        }
        return  humidity
    }
    
    func weatherDescription() -> String {
        guard let weatherDescription = self.weatherDetails?.weather?.first?.weatherDescription else {
            return ""
        }
        return weatherDescription
    }
}
