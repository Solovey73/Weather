//
//  GalleryCollectionView.swift
//  Weather
//
//  Created by Вячеслав on 10/28/23.
//

import UIKit

protocol GaleryCollectionViewDelegate: AnyObject {
    func showDetailViewController(index: Int)
}

class GalleryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var cells = [List]()
    weak var myDelegate: GaleryCollectionViewDelegate?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .clear
        delegate = self
        dataSource = self
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = Constants.galleryMinimumLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: Constants.leftDistanceToView, bottom: 0, right: Constants.rightDistanceToView)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    func set(cells: [List]) {
        self.cells = cells
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as! GalleryCollectionViewCell
        let cellList = cells[indexPath.row]
        
        cell.nameLabel.text = String(format: "%.0f", cellList.main.temp) + " ˚C"
        cell.smallDescriptionLabel.text = cellList.weather.first!.descriptionString
        cell.mainImageView.image = UIImage(systemName: cellList.systemIconNameString)
        cell.mainImageView.tintColor = .red
        switch indexPath.row {
        case 0:
            cell.costLabel.text = "Ceгодня"
        case 1:
            cell.costLabel.text = "Завтра"
        case 2:
            cell.costLabel.text = "Послеавтра"
        default:
            let dateString = cellList.dtTxt

            // Создаем экземпляр DateFormatter для парсинга строки
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

            // Парсим строку в объект Date
            if let date = dateFormatter.date(from: dateString) {
                // Создаем новый DateFormatter для форматирования объекта Date обратно в строку с датой
                let dateOnlyFormatter = DateFormatter()
                dateOnlyFormatter.dateFormat = "dd-MM-yyyy"
                
                // Форматируем объект Date в строку с датой без времени
                cell.costLabel.text = dateOnlyFormatter.string(from: date)
                 // Выводит: "2023-10-31"
            } else {
                print("Ошибка при парсинге даты")
            }
        }
        return cell
    }
    
    //настройка размера ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.galleryItemWidth, height: frame.height * 0.8)
    }
    
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        myDelegate?.showDetailViewController(index: indexPath.row)
    }
}

struct Constants {
    static let leftDistanceToView: CGFloat = 40
    static let rightDistanceToView: CGFloat = 40
    static let galleryMinimumLineSpacing: CGFloat = 10
    static let galleryItemWidth = (UIScreen.main.bounds.width - Constants.leftDistanceToView - Constants.rightDistanceToView - (Constants.galleryMinimumLineSpacing / 2)) / 2
}
