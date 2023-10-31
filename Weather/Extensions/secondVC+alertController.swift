//
//  ViewController+alertController.swift
//  Weather
//
//  Created by Вячеслав on 10/24/23.
//

import Foundation
import UIKit

extension SecondVC {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping (String) -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            let cities = ["Москва", "Уфа", "Саратов", "Ульяновск"]
            tf.placeholder = cities.randomElement()
        }
        let search = UIAlertAction(title: "Искать", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(city)
            }
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    func presentErrorAlertController() {
        let ac = UIAlertController(title: "Ошибка", message: "Проверьте соединение с интернетом или правильность написания города", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Oк", style: .default, handler: nil)
        ac.addAction(ok)
        present(ac, animated: true, completion: nil)
    }
}
