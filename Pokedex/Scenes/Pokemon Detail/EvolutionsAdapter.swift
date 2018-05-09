import Foundation
import UIKit
import Domain
import RxCocoa
import RxSwift
import Layout

class EvolutionsAdapter: TableBaseAdapter<Evolutions> {
    private let bag = DisposeBag()

    override func attach(collectionView: UICollectionView?) {
        super.attach(collectionView: collectionView)

        collectionView?.registerLayout(named: R.file.evolutionListItemCellXml.fullName,
                                       forCellReuseIdentifier: "EvolutionListItem")
    }

    override func update(items: [Evolutions]) {
        guard let collectionView = collectionView else { return }

        bag << Observable.just(items).bind(to: collectionView.rx.items) {
            (collectionView: UICollectionView, row: Int, element: Evolutions) -> UICollectionViewCell in
            let node = collectionView.dequeueReusableCellNode(withIdentifier: "EvolutionListItem",
                                                              for: IndexPath(row: row, section: 0))

            node.setState(["evolution": element])

            //swiftlint:disable:next force_cast
            let cell = node.view as! EvolutionListItemCell

            cell.image.kf.setImage(with: URL(string: element.image), placeholder: nil)

            return cell
        }
    }
}

extension Reactive where Base: EvolutionsAdapter {
    var updateItems: Binder<[Evolutions]> {
        return Binder(self.base) { (target: EvolutionsAdapter, value: [Evolutions]) in
            target.update(items: value)
        }
    }
}
