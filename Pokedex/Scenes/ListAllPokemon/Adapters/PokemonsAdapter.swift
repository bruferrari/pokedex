import Foundation
import UIKit
import Domain
import RxCocoa
import RxSwift
import Layout
import Kingfisher

class PokemonsAdapter: TableBaseAdapter<Pokemon> {
    private let bag = DisposeBag()

    override func attach(tableView: UITableView?) {
        super.attach(tableView: tableView)

        tableView?.registerLayout(named: R.file.pokemonListItemCellXml.fullName,
                forCellReuseIdentifier: "PokemonListItem")
    }

    override func update(items: [Pokemon]) {
        guard let tableView = tableView else { return }

        bag << Observable.just(items)
            .bind(to: tableView.rx.items) { (tableView: UITableView, row: Int, element: Pokemon) -> UITableViewCell in
                let node = tableView.dequeueReusableCellNode(withIdentifier: "PokemonListItem",
                        for: IndexPath(row: row, section: 0))

                node.setState(["pokemon": element])

                //swiftlint:disable:next force_cast
                let cell = node.view as! PokemonListItemCell

                cell.pokemonImage.kf.setImage(with: URL(string: element.image))
                
                return cell
            }
    }

}

extension Reactive where Base: PokemonsAdapter {
    var itemSelected: Observable<Pokemon> {
        guard let tableView = base.tableView else { return Observable.never() }
        return tableView.rx.modelSelected(Pokemon.self)
            .asObservable()
    }

    var updateItems: Binder<[Pokemon]> {
        return Binder(self.base) { (target: PokemonsAdapter, value: [Pokemon]) in
            target.update(items: value)
        }
    }
}
