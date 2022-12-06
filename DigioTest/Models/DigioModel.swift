//
//  DigioModel.swift
//  DigioTest
//
//  Created by Vlad Lopes on 05/12/22.
//

import Foundation

struct DigioModel: Codable {
    var spotlight: [BannerModel]
    var products: [ProductModel]
    var cash: CashModel
}

struct BannerModel: Codable {
    var name: String
    var bannerURL: String
    var description: String
}

struct ProductModel: Codable {
    var name: String
    var imageURL: String
    var description: String
    
}

struct CashModel: Codable {
    var title: String
    var bannerURL: String
    var description: String
}
