//
//  LtkFeedSectionController.swift
//  LTKMinified
//
//  Created by William Powers on 5/19/22.
//

import IGListKit

final class LtkFeedSectionController: ListSectionController, ListWorkingRangeDelegate {
    static let sideMargin: CGFloat = 16.0
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
            let imageSize = ltkModel?.heroImageSize ?? CGSize(width: 0.0, height: 0.0000001)
            let imageAspect = imageSize.width / imageSize.height
            let normalizedHeight = (width - Self.sideMargin) * imageAspect
            return CGSize(width: width, height: normalizedHeight)
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

    override func didUpdate(to object: Any) {
        guard let ltk = object as? LtkModel else { return }
        self.ltkModel = ltk
    }

    func listAdapter(
        _ listAdapter: ListAdapter,
        sectionControllerWillEnterWorkingRange sectionController: ListSectionController
    ) {
        guard ltkImage == nil, let model = ltkModel else { return }

        ProductService.shared.fetchProductImage(with: model.heroImage) { [weak self] result in
            if case let .success(image) = result {
                self?.handleImage(image)
            }
        }
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {}

    private func handleImage(_ image: UIImage?) {
        guard let image = image else { return }
        DispatchQueue.main.async {
            self.ltkImage = image
            if let cell = self.collectionContext?.cellForItem(at: 0, sectionController: self) as? LtkCell {
                cell.setImage(image: image)
            }
        }
    }
}
