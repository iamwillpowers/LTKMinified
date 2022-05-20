//
//  Services.swift
//  ProductViewer
//
//  Created by William Powers on 5/14/22.
//  Copyright © 2022 Target. All rights reserved.
//

import UIKit

final class ProductService {
    enum ServiceError: Error {
        case invalidData(Data?)
        case invalidUrl
        case requestError(Error?)
    }

    typealias DataCompletion = (Result<Data, Error>) -> Void
    typealias ProductsCompletion = (Result<LtkResponse, Error>) -> Void
    typealias ImageCompletion = (Result<UIImage?, Error>) -> Void

    static let shared = ProductService()

    //var errorLogger: ErrorLogging = Logger

    private let fetchLtksUrl: String = "https://api-gateway.rewardstyle.com/api/ltk/v2/ltks/?featured=true&limit=20"

    func fetchProfiles(completion: @escaping ProductsCompletion) {
        guard let targetURL = URL(string: fetchLtksUrl) else {
            completion(.failure(ServiceError.invalidUrl))
            return
        }

        getRequest(URLRequest(url: targetURL)) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let ltks = try LtkResponse(from: data)
                    completion(.success(ltks))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchProductImage(with url: String, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        guard let targetURL = URL(string: url) else {
            completion(.failure(ServiceError.invalidUrl))
            return
        }

        getRequest(URLRequest(url: targetURL)) { result in
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getRequest(_ request: URLRequest, completion: @escaping DataCompletion) {
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            let statusCode = httpResponse?.statusCode ?? 0

            guard error == nil && data != nil && (200..<300).contains(statusCode) else {
                if let httpResponse = httpResponse {
                    // self?.errorLogger.logHTTP(error: error, request: request, response: httpResponse)
                } else if let error = error {
                    // self?.errorLogger.logNonFatal(error: error)
                }
                completion(.failure(ServiceError.requestError(error)))
                return
            }

            completion(.success(data ?? Data()))
        }
        .resume()
    }
}
