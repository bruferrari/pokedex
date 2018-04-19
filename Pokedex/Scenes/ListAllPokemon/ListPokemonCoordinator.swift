import UIKit
import GraphQlPlatform
import RxSwift

final class ListPokemonCoordinator: CoordinatorType, AutoCoordinatorDelegation {
    enum Path: CoordinatorPath {
        case showPokemon
    }

    var window: UIWindow!
    var children: [CoordinatorType]

    weak var delegate: ListPokemonCoordinatorDelegate?

    init(window: UIWindow) {
        self.window = window
        self.children = []
    }

    func start() {
        let graphQLProvider = UseCaseProvider()

        let viewModel = ListPokemonViewModel(coordinator: self, useCase: graphQLProvider.pokemonUseCase())
        let viewController = ListPokemonViewController(layoutName: R.file.listPokemonViewXml.name,
                                                       viewModel: viewModel)

        let navigationController = UINavigationController(rootViewController: viewController)

        window.rootViewController = navigationController
    }

    func route(to path: CoordinatorPath) {
        guard let path = path as? Path else { return }
        switch path {
        case .showPokemon:
            let coordinator = PokemonDetailCoordinator(window: window)
            coordinator.delegate = self
            setupAndInit(coordinator: coordinator)
        }
    }

    func finish(withTransition transition: CloseTransition) { }
}

extension ListPokemonCoordinator: PokemonDetailCoordinatorDelegate {
    func pokemonDetailCoordinatorDidFinish(_ coordinator: PokemonDetailCoordinator) {
        remove(child: coordinator)
    }
}
