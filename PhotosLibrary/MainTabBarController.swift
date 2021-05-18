//
//  MainTabBarController.swift
//  PhotosLibrary
//
//  Created by Антон on 18.05.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
       
    }
    
    
    
    //MARK: - Methods
    
    private func setupTabBar() {
        let photoVC = PhotosViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let vc = ViewController()
        
        viewControllers = [
            generateNavigationVC(rootVC: photoVC, image: UIImage(systemName: "photo.on.rectangle.angled")!, title: "Photos"),
            generateNavigationVC(rootVC: vc, image: UIImage(systemName: "heart.text.square")!, title: "Favourites")
        ]
    }
    
    private func generateNavigationVC(rootVC: UIViewController, image: UIImage, title: String) -> UINavigationController {
        
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.tabBarItem.title = title
        navVC.tabBarItem.image = image
        
        return navVC
        
    }
}
