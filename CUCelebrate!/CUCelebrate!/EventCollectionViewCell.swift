//
//  EventCollectionViewCell.swift
//  CUCelebrate!
//
//  Created by Aliva Das on 4/24/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var name: UILabel!
    var date: UILabel!
    var placeTime: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = false
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        name.adjustsFontSizeToFitWidth = true
        name.minimumScaleFactor = 10
        contentView.addSubview(name)
        
        date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        date.textColor = .darkGray
        date.adjustsFontSizeToFitWidth = true
        date.minimumScaleFactor = 10
        contentView.addSubview(date)
        
        placeTime = UILabel()
        placeTime.translatesAutoresizingMaskIntoConstraints = false
        placeTime.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        placeTime.adjustsFontSizeToFitWidth = true
        placeTime.minimumScaleFactor = 10
        contentView.addSubview(placeTime)
        
        setupConstraints()
    }
    
    func configure(for event: Event) {
        self.imageView.image = event.image
        self.name.text = event.eventName
        self.date.text = event.eventDate
        self.placeTime.text = event.eventVenue + " · " + event.eventTime
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 2*contentView.frame.height/3.0),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            date.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 2*Constants.padding),
            date.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2*Constants.padding),
            date.heightAnchor.constraint(equalToConstant: 2*Constants.labelHeight),
            date.widthAnchor.constraint(equalToConstant: 100)
            ])
        
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: date.trailingAnchor, constant: 4*Constants.padding),
            name.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2*Constants.padding),
            name.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            name.widthAnchor.constraint(equalToConstant: contentView.frame.width - 4*Constants.padding)
            ])
        
        NSLayoutConstraint.activate([
            placeTime.leadingAnchor.constraint(equalTo: date.trailingAnchor, constant: 4*Constants.padding),
            placeTime.topAnchor.constraint(equalTo: name.bottomAnchor, constant: Constants.padding),
            placeTime.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            placeTime.widthAnchor.constraint(equalToConstant: contentView.frame.width - 4*Constants.padding)
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
