import Foundation
import UIKit
import RxSwift
import RxCocoa

final class ListPokemonViewController: BaseViewController<ListPokemonViewModel> {

    private let adapter = PokemonsAdapter()
    @objc var searchBar: UISearchBar!
    @objc var collectionView: UICollectionView!
    @objc var activityIndicator: UIActivityIndicatorView!

    static var layoutConstants: [String: Any] {
        var constants = Font.layoutConstants
        constants ["string.listAllPokemon.title"] = R.string.listAllPokemon.listAllPokemonTitle()
        constants ["string.listAllPokemon.search.hint"] = R.string.listAllPokemon.listAllPokemonSearchHint()

        return constants
    }

    convenience init(layoutName: String, viewModel: ListPokemonViewModel) {
        self.init(viewModel: viewModel)

        loadLayout(named: R.file.listPokemonViewXml.fullName,
                   state: [:],
                   constants: ListPokemonViewController.layoutConstants)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required init(viewModel: ListPokemonViewModel) {
        super.init(viewModel: viewModel)
    }

    override func rebuildView() {
        adapter.attach(collectionView: collectionView)

        bag << [
            viewModel.output.isLoading.drive(activityIndicator.rx.isAnimating),
            viewModel.output.pokemon.drive(adapter.rx.updateItems),
            adapter.rx.itemSelected.bind(to: viewModel.input.selectPokemon),
            searchBar.rx.text.orEmpty.distinctUntilChanged()
                .throttle(0.5, scheduler: MainScheduler.instance)
                .bind(to: viewModel.input.searchFilter)
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(firstColor: UIColor(red: 0.92, green: 0.96, blue: 0.71, alpha: 1.0),
                                   secondColor: UIColor(red: 0.46, green: 0.79, blue: 0.81, alpha: 1.0))

    }
}
