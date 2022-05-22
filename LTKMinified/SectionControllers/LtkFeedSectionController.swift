//
//  LtkFeedSectionController.swift
//  LTKMinified
//
//  Created by William Powers on 5/19/22.
//

import IGListKit
import SwiftUI

final class LtkFeedSectionController: ListSectionController, ListWorkingRangeDelegate {
    static let sideMargin: CGFloat = 8.0
    private var ltkModel: LtkModel?
    private var ltkImage: UIImage?
    

    override init() {
        super.init()
        inset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        workingRangeDelegate = self
    }

    override func numberOfItems() -> Int {
        return 1
    }

    override func sizeForItem(at index: Int) -> CGSize {
        let width: CGFloat = collectionContext?.containerSize.width ?? 0
        switch index {
        case 0:
            let adjustedWidth = (width - Self.sideMargin)
            let adjustedHeight = adjustedWidth * (ltkModel?.heroImageSize.aspect() ?? 0.0)
            return CGSize(width: adjustedWidth, height: adjustedHeight)
        default:
            return CGSize.zero
        }
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext.dequeueReusableCell(of: LtkCell.self, for: self, at: index)
        if let cell = cell as? LtkCell {
            cell.setImage(image: ltkImage)
        }
        return cell
    }

    override func didSelectItem(at index: Int) {
        guard
            let ltkViewController = viewController as? LtkViewController,
            let model = ltkModel
        else { return }

        let hostController = UIHostingController(rootView: DetailsView(ltkModel: model))
        let view = UIImageView(image: UIImage(named: "logo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        hostController.navigationItem.titleView = view
        view.constrainWidthAndHeight(60, 22)
        ltkViewController.navigationController?.pushViewController(hostController, animated: true)
    }

    override func didUpdate(to object: Any) {
        guard let ltk = object as? LtkModel else { return }
        self.ltkModel = ltk
    }

    func listAdapter(
        _ listAdapter: ListAdapter,
        sectionControllerWillEnterWorkingRange sectionController: ListSectionController
    ) {
        guard ltkImage == nil, let model = ltkModel else { return }

        ProductService.shared.fetchImage(with: model.heroImageUrl) { [weak self] result in
            if case let .success(image) = result {
                self?.handleImage(image)
            }
        }
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {}

    private func handleImage(_ image: UIImage?) {
        guard let image = image else { return }
        DispatchQueue.main.async {
            // store the image here in case the ltk is selected, so that details doesn't reload it
            self.ltkModel?.heroImage = image
            if let cell = self.collectionContext?.cellForItem(at: 0, sectionController: self) as? LtkCell {
                cell.setImage(image: image)
            }
        }
    }
}
