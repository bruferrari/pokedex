import Foundation
import UIKit
import RxSwift
import RxCocoa

final class ListPokemonViewController: BaseViewController<ListPokemonViewModel> {
    private let adapter = PokemonsAdapter()

    @objc var tableView: UITableView!
    @objc var activityIndicator: UIActivityIndicatorView!

    override func rebuildView() {
        adapter.attach(tableView: tableView)

        bag << [
            viewModel.output.isLoading.drive(activityIndicator.rx.isAnimating),
            viewModel.output.pokemon.drive(adapter.rx.updateItems),
            adapter.rx.itemSelected.bind(to: viewModel.input.selectPokemon)
        ]
    }
}
