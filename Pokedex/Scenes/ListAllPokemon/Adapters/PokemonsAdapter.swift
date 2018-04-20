import Foundation
import UIKit
import Domain
import RxCocoa
import RxSwift
import Layout
import Kingfisher

class PokemonsAdapter: TableBaseAdapter<Pokemon> {
    private let bag = DisposeBag()

    override func attach(collectionView: UICollectionView?) {
        super.attach(collectionView: collectionView)

        collectionView?.registerLayout(named: R.file.pokemonListItemCellXml.fullName,
                forCellReuseIdentifier: "PokemonListItem")
    }

    override func update(items: [Pokemon]) {
        guard let collectionView = collectionView else { return }

        Observable.just(items).bind(to: collectionView.rx.items)
        {(collectionView: UICollectionView, row: Int, element: Pokemon) -> UICollectionViewCell in
                let node = collectionView.dequeueReusableCellNode(withIdentifier: "PokemonListItem",
                        for: IndexPath(row: row, section: 0))

                node.setState(["pokemon": element])

                //swiftlint:disable:next force_cast
                let cell = node.view as! PokemonListItemCell

                cell.image.kf.setImage(with: URL(string: element.image),
                                       placeholder: nil)

                return cell
            }.disposed(by: bag)
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
