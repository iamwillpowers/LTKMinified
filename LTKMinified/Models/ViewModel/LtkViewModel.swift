//
//  LtkViewModel.swift
//  LTKMinified
//
//  Created by William Powers on 5/19/22.
//

import UIKit

final class LtkViewModel {
    var ltks: [LtkModel] = []

    func loadLtks(completion: @escaping (Result<Void, Error>) -> Void) {
        ProductService.shared.fetchProfiles { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                model.ltks.forEach { ltk in
                    self.ltks.append(LtkModel(from: ltk))
                }
                completion(.success(()))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
