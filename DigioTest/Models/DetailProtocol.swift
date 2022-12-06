//
//  DetailProtocol.swift
//  DigioTest
//
//  Created by Vlad Lopes on 05/12/22.
//

import Foundation


protocol DetailProtocol: class {
    func callDetail(_ offer: OfferModel)
}

protocol CarouselProtocol: class {
    func callMain(_ offer: OfferModel)
}
