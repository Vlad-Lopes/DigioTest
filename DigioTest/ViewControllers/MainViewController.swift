//
//  MainViewController.swift
//  DigioTest
//
//  Created by Vlad Lopes on 01/12/22.
//
import Foundation
import UIKit

class MainViewController: UIViewController, DetailProtocol {
    // MARK: - Variables
    var userName = "Vlademir"
    var bannerList: [OfferModel] = []
    var productList: [OfferModel] = []
    var cashItem = OfferModel(name: "", url: "", description: "", image: UIImage())
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        getData()
    }
    
    func getData() {
        let mainManager = MainManager()
        mainManager.getOffers() {
            (banners, products, cash) in
            self.bannerList = banners ?? []
            self.productList = products ?? []
            self.cashItem = cash ?? OfferModel(name: "", url: "", description: "", image: UIImage())
            
            self.setupView()
        }
    }

    // MARK: - View Navigation
    private func setupNavigation() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    func callDetail(_ offer: OfferModel) {
        let vc = DetailViewController()
        vc.userName = userName
        vc.offer = offer
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Setup View
    private func setupView() {
        let mainView = MainView(name: userName, banners: bannerList, products: productList, cash: cashItem)
        view.backgroundColor = .white
        mainView.delegate = self

        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

    }
}
