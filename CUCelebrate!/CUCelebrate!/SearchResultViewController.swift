//
//  SearchResultViewController.swift
//  CUCelebrate!
//
//  Created by Admin on 4/25/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {

    var searchResults: UICollectionView!
    var searchResultsDelegate: EventCollectionViewDelegate!
    var searchResultsDataSource: EventCollectionViewDataSource!
    
    let SEARCH_REUSE_ID = "Search Reuse Identifier"
    
    init(data: [Event]){
        searchResultsDataSource = EventCollectionViewDataSource(events: data, reuseIdentifier: SEARCH_REUSE_ID)
        searchResultsDelegate = EventCollectionViewDelegate()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search results"
        
        searchResults = UICollectionView()
        searchResults.translatesAutoresizingMaskIntoConstraints = false
        searchResults.delegate = searchResultsDelegate
        searchResults.dataSource = searchResultsDataSource
        view.addSubview(searchResults)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
