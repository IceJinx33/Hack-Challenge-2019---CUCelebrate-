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
    
    let placeholderImage = UIImage(named: "cu_placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //TODO add code here
        imageView = UIImageView(image: placeholderImage)
        imageView.contentMode = .scaleAspectFill
        
        name = UILabel()
        
        date = UILabel()
        placeTime = UILabel()
        
        setupConstraints()
    }
    
    
    
    func configure(for event: Event) {
        self.imageView.image = event.image
        self.name.text = event.eventName
        self.date.text = event.eventDate
        self.placeTime.text = event.eventVenue + " · " + event.eventTime
    }
    
    func setupConstraints() {
        // TODO add constraints here
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
