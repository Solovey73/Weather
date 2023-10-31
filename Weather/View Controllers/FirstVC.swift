import UIKit
import CoreLocation
final class FirstVC: UIViewController {
    
    @IBOutlet var activitiIndicator: UIActivityIndicatorView!
    
    var networkWeatherManager = NetworkWeatherManager()
    lazy var locationManager:CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    var fiveDayWeatherForecast: FiveDayWeatherForecast?
    
    override func viewDidLoad() {
        networkWeatherManager.fiveDayWeatherForecastCompletion = actionAfterFetchFiveDayWeatherForecast(fiveDayWeatherForecast:)
    }
    
    func actionAfterFetchFiveDayWeatherForecast(fiveDayWeatherForecast: FiveDayWeatherForecast?) {
        if fiveDayWeatherForecast != nil {
            UserDefaults.standard.setValue(fiveDayWeatherForecast!.cityName, forKey: "mainCity")
            DispatchQueue.main.async {
                self.activitiIndicator.stopAnimating()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "secondVC") as! SecondVC
                viewController.fiveDayWeatherForecast = fiveDayWeatherForecast
                self.present(viewController, animated: true)
            }
        } else {
            DispatchQueue.main.async {
                self.activitiIndicator.stopAnimating()
                self.presentErrorAlertController()
            }
        }
        
        
    }
    
    @IBAction func useLocationButton(_ sender: Any) {
        activitiIndicator.startAnimating()
        DispatchQueue.global(qos: .userInteractive).async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    self.locationManager.requestLocation()
                }
            } else {
                DispatchQueue.main.async {
                    self.activitiIndicator.stopAnimating()
                    self.presentErrorAlertController()
                }
            }
        }
    }
    
    @IBAction func useCityButton(_ sender: Any) {
        presentSearchAlertController(withTitle: "Введите название города",
                                       message: nil, style: .alert) { city in
            self.activitiIndicator.startAnimating()
            self.networkWeatherManager.fetchFiveDayWeatherForecast(forRequestType: .cityName(city: city))
        }
    }
}
