//
//  CarouselCollectionViewCell.swift
//  DigioTest
//
//  Created by Vlad Lopes on 02/12/22.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    
    // MARK: - SubViews
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 15
        return iv
    }()
    
    // MARK: - Properties
    static let cellId = "CarouselCell"
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - Setups
private extension CarouselCollectionViewCell {
    func setupUI() {
        backgroundColor = .clear
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
        imageView.topAnchor.constraint(equalTo: topAnchor),
        imageView.widthAnchor.constraint(equalTo: widthAnchor),
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        imageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}

// MARK: - Public
extension CarouselCollectionViewCell {
    public func configure(image: UIImage?) {
        imageView.image = image
    }
}
