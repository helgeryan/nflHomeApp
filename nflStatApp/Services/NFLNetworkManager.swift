//
//  NFLNetworkManager.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/2/23.
//

import Foundation
import Alamofire

class NFLNetworkManager {
    
    func makeRequest<T: Codable>(router: NFLRouter, useMockData: Bool = true) async -> T? {
        await withCheckedContinuation { continuation in
            if !useMockData {
                AF.request(router.baseUrl + router.path, method: router.method, parameters: router.parameters, encoding: router.parameterEncoding).response(completionHandler: { response in
                    switch response.result {
                    case .success(let data):
                        let decoder = JSONDecoder()
                        let json = try! decoder.decode(T.self, from: data!)
                        continuation.resume(returning: json)
                        break
                    case .failure(let error):
                        continuation.resume(returning: nil)
                        break
                    }
                })
            } else {
                let url = Bundle.main.url(forResource: router.mockDataFileName, withExtension: "json")!
                let data = try! Data(contentsOf: url)
                let decoder = JSONDecoder()
                let json = try! decoder.decode(T.self, from: data)
                continuation.resume(returning: json)
            }
        }
    }
}

