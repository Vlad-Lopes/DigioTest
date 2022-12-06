//
//  MainView.swift
//  DigioTest
//
//  Created by Vlad Lopes on 02/12/22.
//

import Foundation
import UIKit

class MainView: UIView, CarouselProtocol {
    // MARK: - Main screen
    fileprivate let mainView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .clear
        return vw
    }()
    
    // MARK: - Screen Elements
    fileprivate let titleView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .clear
        return vw
    }()
    
    fileprivate let iconView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.image = (UIImage(named: "digioIcon"))
        return iv
    }()
    
    fileprivate let nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .left
        lb.textColor = .black
        lb.font = .boldSystemFont(ofSize: 20)
        return lb
    }()
 
    fileprivate let carouselBannerView: CarouselCollectionView = {
        let vw = CarouselCollectionView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .clear
        return vw
    }()

    fileprivate let cashLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .left
        return lb
    }()

    fileprivate let cashBanner: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    fileprivate let productLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Produtos"
        lb.textAlignment = .left
        lb.textColor = .black
        lb.font = .boldSystemFont(ofSize: 25)
        return lb
    }()
    
    fileprivate let carouselProductView: CarouselCollectionView = {
        let vw = CarouselCollectionView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .clear
        return vw
    }()
    // MARK: - Variables
    var bannerHeight = CGFloat(180)
    var productHeight = CGFloat(120)
    var cashOffer: OfferModel?
    
    weak var delegate: DetailProtocol?
    
    // MARK: - Initializers
    init(name: String, banners: [OfferModel], products: [OfferModel], cash: OfferModel){
        super.init(frame: CGRect())
    
        cashOffer = cash
        setupCarousels(banners, products)
        personalize(name)
        setupUI()

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Local functions
    func callMain(_ offer: OfferModel) {
        delegate?.callDetail(offer)
    }
    
    @objc func cashTapped(sender: UITapGestureRecognizer) {
        delegate?.callDetail(cashOffer!)
    }
    
    func setupCarousels(_ banners: [OfferModel], _ products: [OfferModel]) {
        if banners.count >= 0 {
            carouselBannerView.configureView(with: banners)
            bannerHeight = banners[0].image.size.height
        }
        carouselBannerView.delegate = self
        
        if products.count >= 0 {
            carouselProductView.configureView(with: products)
            productHeight = products[0].image.size.height
        }
        carouselProductView.delegate = self
    }
    // MARK: - Adjusting elements
    func personalize(_ userName: String) {
        nameLabel.text = "Ola, \(userName)"
        
        let cashText = NSMutableAttributedString(string: "digio", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)])
        let cashText2 = NSMutableAttributedString(string: " Cash", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)])
        cashText.append(cashText2)
        cashLabel.attributedText = cashText

        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.cashTapped))
        cashBanner.addGestureRecognizer(gesture)
        cashBanner.image = cashOffer?.image
    }
    
    // MARK: - Screen construction
    func setupUI() {
        // MARK - Defining safe area
        let margins = self.layoutMarginsGuide
        let guide = self.safeAreaLayoutGuide
        
        // MARK - Creating mainView
        addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
            mainView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            guide.bottomAnchor.constraint(equalToSystemSpacingBelow: mainView.bottomAnchor, multiplier: 1.0)
        ])
        // MARK - Adding Elements
        mainView.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            titleView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20)
        ])

        titleView.addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            iconView.leftAnchor.constraint(equalTo: titleView.leftAnchor)
        ])
        
        titleView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            nameLabel.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 10)
        ])

        mainView.addSubview(carouselBannerView)
        NSLayoutConstraint.activate([
            carouselBannerView.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 35),
            carouselBannerView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
            carouselBannerView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.9),
            carouselBannerView.heightAnchor.constraint(equalToConstant: bannerHeight)
        ])

        mainView.addSubview(cashLabel)
        NSLayoutConstraint.activate([
            cashLabel.topAnchor.constraint(equalTo: carouselBannerView.bottomAnchor, constant: 35),
            cashLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
        ])
        
        mainView.addSubview(cashBanner)
        NSLayoutConstraint.activate([
            cashBanner.topAnchor.constraint(equalTo: cashLabel.bottomAnchor, constant:10),
            cashBanner.leftAnchor.constraint(equalTo: cashLabel.leftAnchor)
        ])
        
        mainView.addSubview(productLabel)
        NSLayoutConstraint.activate([
            productLabel.topAnchor.constraint(equalTo: cashBanner.bottomAnchor, constant: 35),
            productLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20)
        ])

        mainView.addSubview(carouselProductView)
        NSLayoutConstraint.activate([
            carouselProductView.topAnchor.constraint(equalTo: productLabel.bottomAnchor, constant: 10),
            carouselProductView.leftAnchor.constraint(equalTo: productLabel.leftAnchor),
            carouselProductView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.9),
            carouselProductView.heightAnchor.constraint(equalToConstant: productHeight)
        ])       
    }
}
