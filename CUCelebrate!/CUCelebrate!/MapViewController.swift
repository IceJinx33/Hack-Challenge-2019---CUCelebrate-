//
//  MapViewController.swift
//  CUCelebrate!
//
//  Created by Aliva Das on 4/26/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

// To be implemented - this view shows location of venue from Google Maps API

class MapViewController: UIViewController {
    
    var mapLabel: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        mapLabel = UITextView()
        mapLabel.isEditable = false
        mapLabel.translatesAutoresizingMaskIntoConstraints = false
        mapLabel.text = "Location from Google Maps API to be shown here - Not yet Implemented"
        mapLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        mapLabel.backgroundColor = .clear
        view.addSubview(mapLabel)
        
        setupConstraints()

        // Do any additional setup after loading the view.
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            mapLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mapLabel.widthAnchor.constraint(equalToConstant: CGFloat(400)),
            mapLabel.heightAnchor.constraint(equalToConstant: CGFloat(400))
            ])
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
