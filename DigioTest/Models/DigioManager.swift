//
//  DigioManager.swift
//  DigioTest
//
//  Created by Vlad Lopes on 05/12/22.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

struct DigioManager {

    func getOffers(completion: @escaping (_ offers: DigioModel?) -> ()) {
        
        let urlBase = "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products"
        let urlComponents = URLComponents(string: urlBase)
        let request = URLRequest(url: (urlComponents?.url)!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print("Erro ao usar API: \(error)")
                return
            }
        
            if let safeData = data {
                guard let offers = try? JSONDecoder().decode(DigioModel.self, from: safeData) else {return}
                
                completion(offers)
            }
        })
        task.resume()
    }

    func getImage(_ url: String, completion: @escaping (_ image: UIImage?) -> ()) {

        guard let url = URL(string: url) else { return }
        AF.request(url).responseImage { response in
            
            if let error = response.error {
                print("Erro ao buscar a imagem: \(error)")
                return
            }

           if case .success(let image) = response.result {
            completion(image)
           }
        }
    }
}


