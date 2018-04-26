import UIKit
import GraphQlPlatform
import RxSwift
import Domain

final class PokemonDetailCoordinator: CoordinatorType, AutoCoordinatorDelegation {
    func start() { }

    var window: UIWindow!
    var children: [CoordinatorType]

    weak var delegate: PokemonDetailCoordinatorDelegate?

    init(window: UIWindow) {
        self.window = window
        self.children = []
    }

    func start(pokemon: Pokemon) {
        let viewModel = PokemonDetailViewModel(coordinator: self, pokemon: pokemon)
        let viewController = PokemonDetailViewController(layoutName: R.file.pokemonDetailXml.name,
                viewModel: viewModel)

        currentViewController?.present(viewController, animated: true)
        print(pokemon)
    }

    func route(to path: CoordinatorPath) { }

    func finish(withTransition transition: CloseTransition) {
        currentViewController?.dismiss(animated: true, completion: {
            self.delegate?.pokemonDetailCoordinatorDidFinish(self)
        })
    }
}
