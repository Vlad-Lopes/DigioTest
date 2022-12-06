//
//  CarouselCollectionViewController.swift
//  DigioTest
//
//  Created by Vlad Lopes on 02/12/22.
//

import UIKit

//private let reuseIdentifier = "Cell"

class CarouselCollectionView: UIView {
    // MARK: - Protocol
    weak var delegate: CarouselProtocol?
    
    // MARK: - View
    private var carouselCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        cv.clipsToBounds = true
        cv.bounces = false
        cv.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: CarouselCollectionViewCell.cellId)
        cv.isUserInteractionEnabled = true
        return cv
    }()
       
    private var carouselData = [OfferModel]()
}

extension CarouselCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: - Controls
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.cellId, for: indexPath) as? CarouselCollectionViewCell else { return UICollectionViewCell() }

        let image = carouselData[indexPath.row].image
        cell.configure(image: image)

        return cell
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.callMain(carouselData[indexPath.row])
    }
    
    // MARK: - Configure
    public func configureView(with data: [OfferModel]) {
        let imageWidth = data[0].image.size.width
        let imageHeight = data[0].image.size.height
        
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: imageWidth, height: imageHeight)
        carouselLayout.sectionInset = .zero
        carouselLayout.minimumLineSpacing = 20

        carouselCollectionView.collectionViewLayout = carouselLayout
        carouselCollectionView.contentSize = carouselLayout.collectionViewContentSize
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        
        addSubview(carouselCollectionView)
        NSLayoutConstraint.activate([
        carouselCollectionView.topAnchor.constraint(equalTo: topAnchor),
        carouselCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
        carouselCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
        carouselCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        carouselData = data
        carouselCollectionView.reloadData()
    }
}
