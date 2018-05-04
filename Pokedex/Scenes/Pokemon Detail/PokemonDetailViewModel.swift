import Foundation
import RxSwift
import RxCocoa
import Domain

struct PokemonDetailViewModel: RxViewModel {
    struct Input {
        let close: AnyObserver<Void>
    }
    struct Output {
        let viewState: Driver<PokemonDetailViewState>
        let pokemon: Driver<Pokemon>
    }

    let input: Input
    let output: Output

    private weak var coordinator: PokemonDetailCoordinator?
    private let closeSubject = PublishSubject<Void>()
    private let nameSubject = PublishSubject<String>()
    private let bag = DisposeBag()

    private let pokemon: Pokemon

    init(coordinator: PokemonDetailCoordinator, pokemon: Pokemon) {
        self.coordinator = coordinator
        self.pokemon = pokemon

        input = Input(close: closeSubject.asObserver())
        output = Output(viewState: Driver.just(PokemonDetailViewState(pokemon: pokemon)),
                        pokemon: Driver.just(pokemon))

        bind()
    }

    private func bind() {
        bag << closeSubject
            .subscribe(onNext: { _ in
                self.coordinator?.finish(withTransition: .dismiss)
            })
    }
}
