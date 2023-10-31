//
//  DailyForecast.swift
//  Weather
//
//  Created by Вячеслав on 10/29/23.
//

import Foundation

struct FiveDayWeatherForecast {
    let lists: [List]
    let cityName: String
    
    
    init?(fiveDayWeatherForecastData: FiveDayWeatherForecastData) {
        let list1 = fiveDayWeatherForecastData.list[0]
        let list2 = fiveDayWeatherForecastData.list[8]
        let list3 = fiveDayWeatherForecastData.list[16]
        let list4 = fiveDayWeatherForecastData.list[24]
        let list5 = fiveDayWeatherForecastData.list[32]
        self.lists = [list1,list2,list3,list4,list5]
        self.cityName = fiveDayWeatherForecastData.city.name
    }
}
