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
        super.init(nibName: nil, bundle: nil)
        title = "Search Results"
        searchResultsDataSource = EventCollectionViewDataSource(events: data, reuseIdentifier: SEARCH_REUSE_ID)
        searchResultsDelegate = EventCollectionViewDelegate(events: data, reuseIdentifier: SEARCH_REUSE_ID, view: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search results"
        view.backgroundColor = Constants.backgroundColor

        let cellSize = (view.safeAreaLayoutGuide.layoutFrame.width - 20)

        let searchResultsLayout = UICollectionViewFlowLayout()
        searchResultsLayout.scrollDirection = .vertical
        searchResultsLayout.minimumInteritemSpacing = Constants.padding
        searchResultsLayout.minimumLineSpacing = 2 * Constants.padding
        searchResultsLayout.itemSize = CGSize(width: cellSize, height: 0.5*cellSize)

        searchResults = UICollectionView(frame: .zero, collectionViewLayout: searchResultsLayout)
        searchResults.translatesAutoresizingMaskIntoConstraints = false
        searchResults.delegate = searchResultsDelegate
        searchResults.dataSource = searchResultsDataSource
        searchResults.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: SEARCH_REUSE_ID)
        searchResults.backgroundColor = view.backgroundColor
        view.addSubview(searchResults)

        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([

            searchResults.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchResults.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchResults.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchResults.rightAnchor.constraint(equalTo: view.rightAnchor)

        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
