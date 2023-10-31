import UIKit
import CoreLocation

final class SecondVC: UIViewController {
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    @IBOutlet var activitiIndicator: UIActivityIndicatorView!
    var galleryCollectionView =  GalleryCollectionView()
    var fiveDayWeatherForecast: FiveDayWeatherForecast?
    var fiveDayWeatherForecastLists: [List] {
        return fiveDayWeatherForecast!.lists
    }
    var currentWeatherForecast: List {
        return fiveDayWeatherForecastLists.first!
    }
    var networkWeatherManager = NetworkWeatherManager()
    var sities = UserDefaults.standard.stringArray(forKey: "сities")!
    
    override func loadView() {
        super.loadView()
        networkWeatherManager.fiveDayWeatherForecastCompletion = actionAfterFetchFiveDayWeatherForecast(fiveDayWeatherForecast:)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if fiveDayWeatherForecast != nil {
            setGaleryCollection()
            settingWithCurrentWeather()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if fiveDayWeatherForecast == nil {
            self.view.bringSubviewToFront(activitiIndicator)
            activitiIndicator.startAnimating()
            networkWeatherManager.fetchFiveDayWeatherForecast(forRequestType: .cityName(city: UserDefaults.standard.string(forKey: "mainCity")!))
        }
    }
    
    func actionAfterFetchFiveDayWeatherForecast(fiveDayWeatherForecast: FiveDayWeatherForecast?) {
        if fiveDayWeatherForecast != nil {
            if !sities.contains(fiveDayWeatherForecast!.cityName) {
                sities.append(fiveDayWeatherForecast!.cityName)
                UserDefaults.standard.set(self.sities, forKey: "сities")
            }
            self.fiveDayWeatherForecast = fiveDayWeatherForecast
            DispatchQueue.main.async {
                self.setGaleryCollection()
                self.activitiIndicator.stopAnimating()
                self.settingWithCurrentWeather()
            }
        } else {
            DispatchQueue.main.async {
                self.activitiIndicator.stopAnimating()
                self.presentErrorAlertController()
            }
        }
    }
    
    
    func settingWithCurrentWeather() {
        self.cityLabel.text = fiveDayWeatherForecast?.cityName
        self.weatherIconImageView.image = UIImage(systemName: currentWeatherForecast.systemIconNameString)
        self.feelsLikeTemperatureLabel.text = String(format: "%.0f", currentWeatherForecast.main.feelsLike) + " ˚C"
        self.temperatureLabel.text = String(format: "%.0f", currentWeatherForecast.main.temp)
    }
    
    func setGaleryCollection() {
        galleryCollectionView.myDelegate = self
        view.addSubview(galleryCollectionView)
        galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galleryCollectionView.topAnchor.constraint(equalTo: feelsLikeTemperatureLabel.bottomAnchor, constant: 10).isActive = true
        galleryCollectionView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        galleryCollectionView.set(cells: fiveDayWeatherForecastLists)
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Введите название города",
                                          message: nil,
                                          style: .alert) { city in
            self.view.bringSubviewToFront(self.activitiIndicator)
            self.activitiIndicator.startAnimating()
        self.networkWeatherManager.fetchFiveDayWeatherForecast(forRequestType: .cityName(city: city))
        }
    }
}

// MARK: - GaleryCollectionViewDelegate
extension SecondVC: GaleryCollectionViewDelegate {
    func showDetailViewController(index: Int) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "detailVC");
        let dVC = vc as! DetailViewController
        dVC.weatherList = fiveDayWeatherForecast?.lists[index]
        self.present(dVC, animated: true)
    }
}
