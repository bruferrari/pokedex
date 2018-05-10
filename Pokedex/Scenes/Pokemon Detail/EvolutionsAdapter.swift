import Foundation
import UIKit
import Domain
import RxCocoa
import RxSwift
import Layout

class EvolutionsAdapter: TableBaseAdapter<Evolutions>, UICollectionViewDelegateFlowLayout {
    private let bag = DisposeBag()

    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 50, bottom: 30, right: 50)

    override func attach(collectionView: UICollectionView?) {
        super.attach(collectionView: collectionView)

        collectionView?.registerLayout(named: R.file.evolutionListItemCellXml.fullName,
                                       forCellReuseIdentifier: "EvolutionListItem")
        collectionView?.delegate = self
    }

    override func update(items: [Evolutions]) {
        guard let collectionView = collectionView else { return }

        bag << Observable.just(items).bind(to: collectionView.rx.items) {
            (collectionView: UICollectionView, row: Int, element: Evolutions) -> UICollectionViewCell in
            let node = collectionView.dequeueReusableCellNode(withIdentifier: "EvolutionListItem",
                                                              for: IndexPath(row: row, section: 0))

            node.setState(["evolution": element])

            if let imageView = node.childNode(withID: "imageView")?.view as? UIImageView {
                imageView.kf.setImage(with: URL(string: element.image), placeholder: nil)
            }

            if items == [] {
                
            }

            //swiftlint:disable:next force_cast
            return node.view as! UICollectionViewCell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension Reactive where Base: EvolutionsAdapter {
    var updateItems: Binder<[Evolutions]> {
        return Binder(self.base) { (target: EvolutionsAdapter, value: [Evolutions]) in
            target.update(items: value)
        }
    }
}
