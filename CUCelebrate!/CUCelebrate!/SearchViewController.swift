//
//  SearchViewController.swift
//  CUCelebrate!
//
//  Created by Admin on 4/25/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//


// WARNING: DEPRECATED
//          Due to an unnotified plan, this class will never be used.

import UIKit

class SearchViewController: UIViewController {

    var startDate: UIDatePicker!
    var endDate: UIDatePicker!
    var startLabel: UILabel!
    var endLabel: UILabel!
    var searchBar: UISearchBar!
    var searchButton: UIButton!
    
    let today = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Find an Event"
        
        startLabel = UILabel()
        setupLabel(startLabel, text: "Start date:")
        
        endLabel = UILabel()
        setupLabel(endLabel, text: "End date:")
        
        startDate = UIDatePicker()
        setupDatePicker(startDate)
        
        endDate = UIDatePicker()
        setupDatePicker(endDate)
        
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.text = "Search by name"
        
        searchButton = UIButton()
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle("Search", for: .normal)
        // TODO check if target is correct
        searchButton.addTarget(self, action: #selector(search), for: .touchUpInside)
        
        setupConstraints()
    }
    
    
    func setupConstraints() {
        
    }

    @objc func search() {
        
    }
    
    func setupLabel(_ label: UILabel, text: String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        view.addSubview(label)
    }
    
    func setupDatePicker(_ picker: UIDatePicker) {
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
//        picker.minimumDate = minDate
//        picker.maximumDate = maxDate
        view.addSubview(picker)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
}
