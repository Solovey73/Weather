//
//  DetailViewController.swift
//  Weather
//
//  Created by Вячеслав on 10/29/23.
//

import UIKit

final class DetailViewController: UIViewController {
    var weatherList: List?
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var feelsLikeLable: UILabel!
    @IBOutlet var tempMinLable: UILabel!
    @IBOutlet var tempMaxLable: UILabel!
    @IBOutlet var pressureLable: UILabel!
    @IBOutlet var humidityLable: UILabel!
    @IBOutlet var cloudsLable: UILabel!
    @IBOutlet var windLable: UILabel!
    @IBOutlet var visabilityLable: UILabel!
    @IBOutlet var popLable: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = UIImage(systemName: weatherList!.systemIconNameString) 
        feelsLikeLable.text = "Ощущается как " + String(weatherList!.main.feelsLike) + "˚C"
        tempMinLable.text = "Минимальная температура " + String(weatherList!.main.tempMin) + "˚C"
        tempMaxLable.text = "Максимальная температура " + String(weatherList!.main.tempMax) + "˚C"
        pressureLable.text = "Давление " + String(weatherList!.main.pressure) + "мм рт.ст."
        humidityLable.text = "Влажность " + String(weatherList!.main.humidity) + "г/м³"
        cloudsLable.text = "Облачность " + String(weatherList!.clouds.all) + "%"
        windLable.text = "Ветер " + String(weatherList!.wind.speed) + " м/сек"
        visabilityLable.text = "Видимость " + String(weatherList!.visibility) + " м"
        popLable.text = "Вероятность выпадения осадков " + String(weatherList!.pop) + "%"

        
    }
    

    

}
