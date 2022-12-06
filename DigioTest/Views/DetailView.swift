//
//  DetailView.swift
//  DigioTest
//
//  Created by Vlad Lopes on 03/12/22.
//

import Foundation
import UIKit

class DetailView: UIView {
    // MARK: - Detail screen
    fileprivate let detailView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .clear
        return vw
    }()
    
    // MARK: - Screen Objects
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
    
    fileprivate let explainLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Veja aqui mais detalhes sobre sua escolha"
        lb.textAlignment = .left
        lb.textColor = .darkGray
        lb.font = .systemFont(ofSize: 18)
        return lb
    }()
    
    fileprivate let titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .left
        lb.textColor = .black
        lb.font = .boldSystemFont(ofSize: 20)
        return lb
    }()
    
    fileprivate let productImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .clear
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.clipsToBounds = true
        return iv
    }()
    
    fileprivate let productView: UIView = {
        let iv = UIView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        return iv
    }()
    
    fileprivate let detailLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        lb.textAlignment = .justified
        lb.textColor = .black
        lb.font = .systemFont(ofSize: 20)
        lb.layer.masksToBounds = true
        return lb
    }()
    
    var imageWidth = CGFloat()
    var imageHeight = CGFloat()
    
    // MARK: - Initializers
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    init(userName: String, offer: OfferModel) {
        super.init(frame: CGRect())
        
        personalize(userName, offer)
        setupUI()
    }
    // MARK: - Adjusting elements
    func personalize(_ userName: String, _ offer: OfferModel) {
        imageWidth = offer.image.size.width
        imageHeight = offer.image.size.height
        
        nameLabel.text = userName
        titleLabel.text = offer.name
        productImage.image = offer.image
        detailLabel.text = offer.description
    }
    
    // MARK: - Screen construction
    func setupUI() {
        // MARK - Defining safe area
        let margins = self.layoutMarginsGuide
        let guide = self.safeAreaLayoutGuide
        
        // MARK - Creating main view
        addSubview(detailView)
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
            detailView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            guide.bottomAnchor.constraint(equalToSystemSpacingBelow: detailView.bottomAnchor, multiplier: 1.0)
        ])
        
        // MARK - Adding elements
        titleView.addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            iconView.leftAnchor.constraint(equalTo: titleView.leftAnchor, constant: 10)
        ])
        
        titleView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            nameLabel.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 10)
        ])
        
        titleView.addSubview(explainLabel)
        NSLayoutConstraint.activate([
            explainLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),
            explainLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor)
        ])
        
        detailView.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 10),
            titleView.leftAnchor.constraint(equalTo: detailView.leftAnchor)
        ])
        
        detailView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: explainLabel.topAnchor, constant: 50),
            titleLabel.leftAnchor.constraint(equalTo: detailView.leftAnchor, constant: 10)
        ])
        
        detailView.addSubview(productImage)
        NSLayoutConstraint.activate([
            productImage.centerXAnchor.constraint(equalTo: detailView.centerXAnchor),
            productImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            productImage.widthAnchor.constraint(equalToConstant: imageWidth),
            productImage.heightAnchor.constraint(equalToConstant: imageHeight)
        ])
        
        detailView.addSubview(detailLabel)
        NSLayoutConstraint.activate([
            detailLabel.centerXAnchor.constraint(equalTo: detailView.centerXAnchor),
            detailLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 30),
            detailLabel.widthAnchor.constraint(equalTo: detailView.widthAnchor, multiplier: 0.8),
        ])
    }
}

