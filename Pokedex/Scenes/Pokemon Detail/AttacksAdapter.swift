import Foundation
import UIKit
import Domain
import RxCocoa
import RxSwift
import Layout

class AttacksAdapter: TableBaseAdapter<Attack> {
    private let bag = DisposeBag()

    override func attach(collectionView: UICollectionView?) {
        super.attach(collectionView: collectionView)

        collectionView?.registerLayout(named: R.file.attacksListItemCellXml.fullName,
                                       forCellReuseIdentifier: "AttacksListItem")
    }

    override func update(items: [Attack]) {
        guard let collectionView = collectionView else { return }

        bag << Observable.just(items).bind(to: collectionView.rx.items) {
            (collectionView: UICollectionView, row: Int, element: Attack) -> UICollectionViewCell in
            let node = collectionView.dequeueReusableCellNode(withIdentifier: "AttacksListItem",
                                                              for: IndexPath(row: row, section: 0))

            node.setState(["attack": element])

            //swiftlint:disable:next force_cast
            let cell = node.view as! UICollectionViewCell

            return cell
        }
    }
}

extension Reactive where Base: AttacksAdapter {
    var updateItems: Binder<[Attack]> {
        return Binder(self.base) { (target: AttacksAdapter, value: [Attack]) in
            target.update(items: value)
        }
    }
}
