import Foundation
import UIKit
import Domain
import RxCocoa
import RxSwift
import Layout
import Kingfisher

class PokemonsAdapter: TableBaseAdapter<Pokemon>,
                       UICollectionViewDelegateFlowLayout {

    fileprivate let itemsPerRow: CGFloat = 2

    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 50.0, bottom: 50.0, right: 50.0)
    
    private let bag = DisposeBag()

    override func attach(collectionView: UICollectionView?) {
        super.attach(collectionView: collectionView)

        collectionView?.registerLayout(named: R.file.pokemonListItemCellXml.fullName,
                forCellReuseIdentifier: "PokemonListItem")
        collectionView?.delegate = self
    }

    override func update(items: [Pokemon]) {
        guard let collectionView = collectionView else { return }

        bag << Observable.just(items).bind(to: collectionView.rx.items) {
            (collectionView: UICollectionView, row: Int, element: Pokemon) -> UICollectionViewCell in
                let node = collectionView.dequeueReusableCellNode(withIdentifier: "PokemonListItem",
                        for: IndexPath(row: row, section: 0))

                node.setState(["pokemon": element])

                //swiftlint:disable:next force_cast
                let cell = node.view as! PokemonListItemCell

                cell.image.kf.setImage(with: URL(string: element.image),
                                       placeholder: nil)

                return cell
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

extension Reactive where Base: PokemonsAdapter {
    var itemSelected: Observable<Pokemon> {
        guard let collectionView = base.collectionView else { return Observable.never() }
        return collectionView.rx.modelSelected(Pokemon.self)
            .asObservable()
    }

    var updateItems: Binder<[Pokemon]> {
        return Binder(self.base) { (target: PokemonsAdapter, value: [Pokemon]) in
            target.update(items: value)
        }
    }
}
