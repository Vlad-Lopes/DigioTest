//
//  MainManager.swift
//  DigioTest
//
//  Created by Vlad Lopes on 06/12/22.
//

import Foundation
import UIKit

struct MainManager {
    
    func getOffers(completion: @escaping (_ banners: [OfferModel]?,_ products: [OfferModel]?,_ cash: OfferModel?) -> ()) {
        var bannerList: [OfferModel] = []
        var productList: [OfferModel] = []
        var cashItem = OfferModel(name: "", url: "", description: "", image: UIImage())
        
        let digioManager = DigioManager()
        let dispatchGroup = DispatchGroup()
          
        digioManager.getOffers() {
            offers in
          
            if let spotlightList = offers?.spotlight {
                dispatchGroup.enter()
                var count = 1
                for sp in spotlightList {
                  digioManager.getImage(sp.bannerURL) {
                  image in
                      
                    bannerList.append(OfferModel(name: sp.name, url: sp.bannerURL, description: sp.description, image: image ?? UIImage()))
                    count += 1
                    if count == spotlightList.count {
                          dispatchGroup.leave()
                    }
                  }
                }
            }
        
            if let productsList = offers?.products {
              dispatchGroup.enter()
              var count = 1
              for prod in productsList {
                  digioManager.getImage(prod.imageURL) {
                  image in

                    productList.append(OfferModel(name: prod.name, url: prod.imageURL, description: prod.description, image: image ?? UIImage()))
                   count += 1
                      if count == productsList.count {
                          dispatchGroup.leave()
                      }
                   }
                }
            }

          if let cash = offers?.cash {
              dispatchGroup.enter()
              digioManager.getImage(cash.bannerURL) {
              image in

                cashItem = OfferModel(name: cash.title, url: cash.bannerURL, description: cash.description, image: image ?? UIImage())
                dispatchGroup.leave()
              }
          }
          
          dispatchGroup.notify(queue: DispatchQueue.main) {
            completion (bannerList, productList, cashItem)
          }
      }
  }
}
