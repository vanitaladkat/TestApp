//
//  WeatherModel.swift
//  TestApp
//
//  Created by Vanita on 11/8/17.
//  Copyright © 2017 Tixdo. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherModel: Mappable {
    var id: Int = 0
    var name: String = ""
    var main: MainDetails?
    var weather: [WeatherDetails]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        main <- map["main"]
        weather <- map["weather"]
    }
}

class MainDetails: Mappable {
    var temp: Float = 0
    var pressure: Int = 0
    var humidity: Int = 0
    var temp_min: Float = 0
    var temp_max: Float = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        temp <- map["temp"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        temp_min <- map["temp_min"]
        temp_max <- map["temp_max"]
    }
}

class WeatherDetails: Mappable {
    var main: String = ""
    var weatherDescription: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        main <- map["main"]
        weatherDescription <- map["description"]
    }
}
