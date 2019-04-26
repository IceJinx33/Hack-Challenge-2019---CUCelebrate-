//
//  DisplayEventViewController.swift
//  CUCelebrate!
//
//  Created by Aliva Das on 4/25/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

class DisplayEventViewController: UIViewController {
    
    var name: UILabel!
    var date: UILabel!
    var time: UILabel!
    var venue: UILabel!
    var checkLabel: UILabel!
    var descText: UITextView!
    var image: UIImageView!
    var timeIcon: UIImageView!
    var mapIcon: UIImageView!
    var mapButton: UIButton!
    var checkButton: UIButton!
    
    let labelHeight = 20
    
    weak var delegate: ChangeMyEventDelegate?
    
    var placeholderEvent: Event!
    
    init(placeholderEvent: Event) {
        self.placeholderEvent = placeholderEvent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
         // Do any additional setup after loading the view.
        view.backgroundColor = .lightGray
        
        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = placeholderEvent.eventName
        name.textAlignment = .center
        name.adjustsFontSizeToFitWidth = true
        name.minimumScaleFactor = 10
        name.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        view.addSubview(name)
        
        date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.text = placeholderEvent.eventDate
        date.adjustsFontSizeToFitWidth = true
        date.minimumScaleFactor = 10
        date.font = UIFont(name: "AmericanTypewriter", size: 16)
        view.addSubview(date)
        
        time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.text = placeholderEvent.eventTime
        time.adjustsFontSizeToFitWidth = true
        time.minimumScaleFactor = 10
        time.font = UIFont(name: "AmericanTypewriter", size: 16)
        view.addSubview(time)
        
        venue = UILabel()
        venue.translatesAutoresizingMaskIntoConstraints = false
        venue.text = placeholderEvent.eventVenue
        venue.adjustsFontSizeToFitWidth = true
        venue.minimumScaleFactor = 10
        venue.font = UIFont(name: "AmericanTypewriter", size: 16)
        view.addSubview(venue)
        
        checkLabel = UILabel()
        checkLabel.translatesAutoresizingMaskIntoConstraints = false
        checkLabel.text = "Add to My Events"
        checkLabel.font = UIFont(name: "AmericanTypewriter", size: 16)
        view.addSubview(checkLabel)
        
        descText = UITextView()
        descText.translatesAutoresizingMaskIntoConstraints = false
        descText.text = placeholderEvent.description
        descText.backgroundColor = .clear
        descText.font = UIFont(name: "AmericanTypewriter", size: 16)
        descText.isEditable = false
        view.addSubview(descText)
        
        image = UIImageView(image: placeholderEvent.image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.isHidden = false
        image.layer.cornerRadius = 10
        image.backgroundColor = .white
        image.layer.borderWidth = 1.0
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.masksToBounds = false
        view.addSubview(image)
        
        timeIcon = UIImageView(image: UIImage(named: "clock"))
        timeIcon.translatesAutoresizingMaskIntoConstraints = false
        timeIcon.contentMode = .scaleAspectFit
        timeIcon.isHidden = false
        view.addSubview(timeIcon)
        
        mapIcon = UIImageView(image: UIImage(named: "map"))
        mapIcon.translatesAutoresizingMaskIntoConstraints = false
        mapIcon.contentMode = .scaleAspectFit
        mapIcon.isHidden = false
        view.addSubview(mapIcon)
        
        mapButton = UIButton()
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        mapButton.setTitle("Find Location on Map", for: .normal)
        mapButton.setTitleColor(.blue, for: .normal)
        //mapButton.addTarget(self, action: #selector(findLocation), for: .touchUpInside)
        view.addSubview(mapButton)
        
        checkButton = UIButton()
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.backgroundColor = .white
        checkButton.setBackgroundImage(UIImage(named: "check"), for: .selected)
        if(placeholderEvent.isMyEvent == true){
            checkButton.isSelected = true
        }
        checkButton.layer.borderWidth = 2
        checkButton.layer.borderColor = UIColor.black.cgColor
        checkButton.setBackgroundImage(UIImage(named: "check"), for: .selected)
        checkButton.addTarget(self, action: #selector(checkBox), for: .touchUpInside)
        view.addSubview(checkButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            image.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.height/3.0)
            ])
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            name.heightAnchor.constraint(equalToConstant: CGFloat(labelHeight))
            ])
        
        NSLayoutConstraint.activate([
            timeIcon.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 25),
            timeIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            timeIcon.widthAnchor.constraint(equalToConstant: CGFloat(2*labelHeight)),
            timeIcon.heightAnchor.constraint(equalToConstant: CGFloat(2*labelHeight))
            ])
        
        NSLayoutConstraint.activate([
            date.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            date.leadingAnchor.constraint(equalTo: timeIcon.trailingAnchor, constant: 20),
            date.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            date.heightAnchor.constraint(equalToConstant: CGFloat(labelHeight))
            ])
        
        NSLayoutConstraint.activate([
            time.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 10),
            time.leadingAnchor.constraint(equalTo: timeIcon.trailingAnchor, constant: 20),
            time.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            time.heightAnchor.constraint(equalToConstant: CGFloat(labelHeight))
            ])
        
        NSLayoutConstraint.activate([
            mapIcon.topAnchor.constraint(equalTo: time.bottomAnchor, constant: 10),
            mapIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mapIcon.widthAnchor.constraint(equalToConstant: CGFloat(2*labelHeight)),
            mapIcon.heightAnchor.constraint(equalToConstant: CGFloat(2*labelHeight))
            ])
        
        NSLayoutConstraint.activate([
            venue.topAnchor.constraint(equalTo: time.bottomAnchor, constant: 20),
            venue.leadingAnchor.constraint(equalTo: mapIcon.trailingAnchor, constant: 20),
            venue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            venue.heightAnchor.constraint(equalToConstant: CGFloat(labelHeight))
            ])
        
        NSLayoutConstraint.activate([
            mapButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            mapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapButton.widthAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width*2/3.0),
            mapButton.heightAnchor.constraint(equalToConstant: CGFloat(labelHeight))
            ])
        
        NSLayoutConstraint.activate([
            checkButton.bottomAnchor.constraint(equalTo: mapButton.topAnchor, constant: -20),
            checkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            checkButton.widthAnchor.constraint(equalToConstant: CGFloat(2*labelHeight)),
            checkButton.heightAnchor.constraint(equalToConstant: CGFloat(2*labelHeight))
            ])
        
        NSLayoutConstraint.activate([
            checkLabel.bottomAnchor.constraint(equalTo: mapButton.topAnchor, constant: -30),
            checkLabel.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 20),
            checkLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            checkLabel.heightAnchor.constraint(equalToConstant: CGFloat(labelHeight))
            ])
        
        NSLayoutConstraint.activate([
            descText.topAnchor.constraint(equalTo: venue.bottomAnchor, constant: 20),
            descText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descText.bottomAnchor.constraint(equalTo: checkLabel.topAnchor, constant: -20),
            ])
    }
    
    @objc func checkBox(){
        checkButton.isSelected = !checkButton.isSelected
        placeholderEvent.isMyEvent = !placeholderEvent.isMyEvent
        delegate?.MyEventChanged(to: placeholderEvent)
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
