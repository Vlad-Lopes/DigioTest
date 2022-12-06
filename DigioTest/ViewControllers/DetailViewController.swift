//
//  DetailViewController.swift
//  DigioTest
//
//  Created by Vlad Lopes on 05/12/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var offer: OfferModel?
    var userName: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {

        guard let name = userName, let detail = offer else { return }
        let detailView = DetailView(userName: name, offer: detail)
        view.backgroundColor = .white
        
        view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            detailView.widthAnchor.constraint(equalTo: view.widthAnchor),
            detailView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
}
