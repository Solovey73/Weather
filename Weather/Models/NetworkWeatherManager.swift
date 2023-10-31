import Foundation
import CoreLocation

struct NetworkWeatherManager {
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    var fiveDayWeatherForecastCompletion: ((FiveDayWeatherForecast?) -> Void)?
    
    func fetchFiveDayWeatherForecast(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&lang=ru&units=metric"
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&lang=ru&units=metric"
        }
        performRequest(withURLString: urlString)
    }
    
    fileprivate func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        else {
            fiveDayWeatherForecastCompletion?(nil)
            print("почемуто выходит")
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, _, _ in
            if let data {
                if let fiveDayWeatherForecast = parseJSON(withData: data) {
                    fiveDayWeatherForecastCompletion?(fiveDayWeatherForecast)
                } else {
                    fiveDayWeatherForecastCompletion?(nil)
                }
            } else {
                fiveDayWeatherForecastCompletion?(nil)
            }
        }
        task.resume()
    }
    
    fileprivate func parseJSON(withData data: Data) -> FiveDayWeatherForecast? {
        let decoder = JSONDecoder()
        do {
            let fiveDayWeatherForecastData = try decoder.decode(FiveDayWeatherForecastData.self, from: data)
            guard let fiveDayWeatherForecast = FiveDayWeatherForecast(fiveDayWeatherForecastData: fiveDayWeatherForecastData)
            else {
                return nil
            }
            return fiveDayWeatherForecast
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
