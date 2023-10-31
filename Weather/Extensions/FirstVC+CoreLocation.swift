//
//  FirstVC+CoreLocation.swift
//  Weather
//
//  Created by Вячеслав on 10/27/23.
//

import Foundation
import CoreLocation
// MARK: - CLLocationManagerDelegate
extension FirstVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        networkWeatherManager.fetchFiveDayWeatherForecast(forRequestType: .coordinate(latitude: latitude, longitude: longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        self.activitiIndicator.stopAnimating()
        self.presentErrorAlertController()
    }
    
    
}
