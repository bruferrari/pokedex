import UIKit
import GraphQlPlatform
import RxSwift

final class PokemonDetailCoordinator: CoordinatorType, AutoCoordinatorDelegation {
    var window: UIWindow!
    var children: [CoordinatorType]

    weak var delegate: PokemonDetailCoordinatorDelegate?

    init(window: UIWindow) {
        self.window = window
        self.children = []
    }

    func start() {
        let viewModel = PokemonDetailViewModel(coordinator: self)
        let viewController = PokemonDetailViewController(layoutName: R.file.pokemonDetailXml.name,
                viewModel: viewModel)

        currentViewController?.present(viewController, animated: true)
    }

    func route(to path: CoordinatorPath) { }

    func finish(withTransition transition: CloseTransition) {
        currentViewController?.dismiss(animated: true, completion: {
            self.delegate?.pokemonDetailCoordinatorDidFinish(self)
        })
    }
}
