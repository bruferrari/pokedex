import UIKit

protocol AppCoordinatorType: CoordinatorType, AutoMockable { }

final class AppCoordinator: AppCoordinatorType {
    private(set) var window: UIWindow!
    var children: [CoordinatorType]

    required init(window: UIWindow) {
        self.window = window
        self.children = []
    }

    func start() {
        let coordinator = ListPokemonCoordinator(window: window)
        coordinator.delegate = self
        setupAndInit(coordinator: coordinator)
    }

    func finish(withTransition transition: CloseTransition) {}

    func route(to path: CoordinatorPath) {}
}

extension AppCoordinator: ListPokemonCoordinatorDelegate {
    func listPokemonCoordinatorDidFinish(_ coordinator: ListPokemonCoordinator) {
        remove(child: coordinator)
    }
}
