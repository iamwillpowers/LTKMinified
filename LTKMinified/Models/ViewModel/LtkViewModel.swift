//
//  LtkViewModel.swift
//  LTKMinified
//
//  Created by William Powers on 5/19/22.
//

import UIKit

final class LtkViewModel {
    var ltkModels: [LtkModel] = []

    func loadLtks(completion: @escaping (Result<Void, Error>) -> Void) {
        ProductService.shared.fetchProfiles { [weak self] result in
            switch result {
            case .success(let model):
                self?.interlaceResult(ltks: model.ltks, profiles: model.profiles, products: model.products)
                completion(.success(()))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func interlaceResult(ltks: [Ltk], profiles: [Profile], products: [Product]) {
        for ltk in ltks {
            guard let profile = profiles.first(where: { $0.id == ltk.profileId }) else {
                // couldn't find matching profile for ltk
                continue
            }
            let products = products.filter({ ltk.productIds.contains($0.id) })
            ltkModels.append(LtkModel(from: ltk, profile: profile, products: products))
        }
    }
}
