//
//  NFLNetworkManager.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/2/23.
//

import Foundation
import Alamofire

class NFLNetworkManager {
    func makeRequest<T: Codable>(router: NFLRouter, useMockData: Bool = true, completion: @escaping (T?) -> ()) {
        if !useMockData {
            AF.request(router.baseUrl + router.path, method: router.method, parameters: router.parameters, encoding: router.parameterEncoding).response(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    let draft = try! decoder.decode(T.self, from: data!)
                    completion(draft)
                    break
                case .failure(let error):
                    completion(nil)
                    break
                }
            })
        } else {
            let url = Bundle.main.url(forResource: router.mockDataFileName, withExtension: "json")!
            let data = try! Data(contentsOf: url)
            let decoder = JSONDecoder()
            let draft = try! decoder.decode(T.self, from: data)
            completion(draft)
        }
    }
}

