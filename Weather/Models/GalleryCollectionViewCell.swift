//
//  GalleryCollectionViewCell.swift
//  Weather
//
//  Created by Вячеслав on 10/28/23.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    static let reuseId = "GalleryCollectionViewCell"
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = #colorLiteral(red: 0.007841579616, green: 0.007844132371, blue: 0.007841020823, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let smallDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let space: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nosign")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let costLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainImageView)
        addSubview(nameLabel)
        addSubview(smallDescriptionLabel)
        addSubview(space)
        addSubview(costLabel)
        
        nameLabel.text = "nameLable"
        smallDescriptionLabel.text = "smallDescriptionLabel"
        costLabel.text = "costLabel"
        
        backgroundColor = .white
        
        //        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        //        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        //        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        //        mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        // mainImageView constraints
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        mainImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3).isActive = true
        
        // nameLabel constraints
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 12).isActive = true
        
        // smallDescriptionLabel constraints
        smallDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        smallDescriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        smallDescriptionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1, constant: 10).isActive = true
        
        // likeImageView constraints
        space.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        space.topAnchor.constraint(equalTo: smallDescriptionLabel.bottomAnchor, constant: 30).isActive = true
        space.widthAnchor.constraint(equalToConstant: 24).isActive = true
        space.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        // costLabel constraints
        costLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        costLabel.centerYAnchor.constraint(equalTo: space.centerYAnchor).isActive = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5
        self.layer.shadowRadius = 9
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        self.clipsToBounds = false
    }
        
        
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
