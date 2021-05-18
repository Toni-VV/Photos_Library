//
//  PhotosViewController.swift
//  PhotosLibrary
//
//  Created by Антон on 18.05.2021.
//

import UIKit

class PhotosViewController: UICollectionViewController {
    
    var network = NetworkDataFetcher()
    
    var timer: Timer?
    
    private var photos = [UnsplashPhoto]()
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapButton))
    }()
    
    private lazy var actionBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionTapButton))
    }()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavigationBar()
        setupSearchBar()
        
    }
    
    //MARK: - Navigationactions
    
    @objc private func addTapButton() {
        
    }
    
    @objc private func actionTapButton() {
        
    }
    
    //MARK: - Setup UI Elements
    
    private func setupCollectionView() {
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.backgroundColor = .systemBlue
        
        
        
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Photos"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.rightBarButtonItems = [addBarButtonItem, actionBarButtonItem]
        
    }
    
    private func setupSearchBar() {
        let searchVC = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchVC
        navigationItem.hidesSearchBarWhenScrolling = false
        searchVC.hidesNavigationBarDuringPresentation = false
        searchVC.obscuresBackgroundDuringPresentation = false
        searchVC.searchBar.delegate = self
        
    }
    
    //MARK: - UICollectionViewDataSource, UICollectionViewDelegate
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier,
                                                      for: indexPath) as! PhotoCell
        
        let unsplashPhoto = photos[indexPath.item]
        cell.unsplashPhoto = unsplashPhoto
        
        return cell
    }
    
}

//MARK: - UISearchBarDelegate

extension PhotosViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
            
            self.network.fetchPhotos(searchTerm: searchText) { [weak self] result in
                guard let response = result else { return }
                self?.photos = response
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        })
        
        }
    }

