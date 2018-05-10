import Foundation
import UIKit
import Domain
import RxCocoa
import RxSwift
import Layout

class AttacksAdapter: TableBaseAdapter<Attack>, UICollectionViewDelegateFlowLayout {
    private let bag = DisposeBag()

    fileprivate let itemsPerRow: CGFloat = 1
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 50.0, bottom: 40, right: 50.0)

    override func attach(collectionView: UICollectionView?) {
        super.attach(collectionView: collectionView)

        collectionView?.registerLayout(named: R.file.attacksListItemCellXml.fullName,
                                       forCellReuseIdentifier: "AttacksListItem")
        collectionView?.delegate = self
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

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: 0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.bottom
    }
}

extension Reactive where Base: AttacksAdapter {
    var updateItems: Binder<[Attack]> {
        return Binder(self.base) { (target: AttacksAdapter, value: [Attack]) in
            target.update(items: value)
        }
    }
}
