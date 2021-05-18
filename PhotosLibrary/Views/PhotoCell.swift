//
//  PhotoCell.swift
//  PhotosLibrary
//
//  Created by Антон on 18.05.2021.
//

import UIKit
import SDWebImage

class PhotoCell: UICollectionViewCell {
    
    static let identifier = "PhotoCell"
    
    private let photoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let checkMarkImage: UIImageView = {
        let image = UIImage(systemName: "checkmark")
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
           let photoURL = unsplashPhoto.urls["regular"]
            guard let imageURL = photoURL, let url = URL(string: imageURL) else {
                return
            }
            photoImage.sd_setImage(with: url, completed: nil)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelectedtate()
        }
    }
    
    override func prepareForReuse() {
        photoImage.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateSelectedtate()
        setupConstraintsPhotoImage()
        setupConstraintsCheckmarkView()
    }
    
    private func updateSelectedtate() {
        photoImage.alpha = isSelected ? 0.7 : 1
        checkMarkImage.alpha = isSelected ? 1 : 0
    }
    
    
    //MARK: - Setup Constraints
    
    private func setupConstraintsPhotoImage() {
        addSubview(photoImage)
        photoImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        photoImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        photoImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupConstraintsCheckmarkView() {
        addSubview(checkMarkImage)
        checkMarkImage.rightAnchor.constraint(equalTo: photoImage.rightAnchor, constant: -8).isActive = true
        checkMarkImage.bottomAnchor.constraint(equalTo: photoImage.bottomAnchor, constant: -8).isActive = true
    }
    
  
    required init?(coder: NSCoder) {
        fatalError()
    }
}
