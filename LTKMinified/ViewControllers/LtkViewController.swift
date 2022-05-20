//
//  ViewController.swift
//  LTKMinified
//
//  Created by William Powers on 5/19/22.
//

import UIKit
import IGListKit

final class LtkViewController: UIViewController {
    private let viewModel: LtkViewModel = LtkViewModel()
    private let collectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "logo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var adapter: ListAdapter = {
      return ListAdapter(
      updater: ListAdapterUpdater(),
      viewController: self,
      workingRangeSize: 0)
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = titleImageView
        NSLayoutConstraint.activate([
            titleImageView.widthAnchor.constraint(equalToConstant: 80),
            titleImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(collectionView)
        adapter.collectionView = collectionView

        viewModel.loadLtks() { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.adapter.dataSource = self
                }
                print("success")
            case .failure(let error):
                print(error)
            }
        }
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(
            x: LtkFeedSectionController.sideMargin / 2.0,
            y: 0,
            width: self.view.bounds.width - LtkFeedSectionController.sideMargin,
            height: self.view.bounds.height
        )
    }
}

extension LtkViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        print(viewModel.ltks.count)
        return viewModel.ltks
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return LtkFeedSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
