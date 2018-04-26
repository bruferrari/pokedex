import Foundation
import RxSwift
import RxCocoa
import Domain

struct ListPokemonViewModel: RxViewModel {
    struct Input {
        let selectPokemon: AnyObserver<Pokemon>
    }
    struct Output {
        let pokemon: Driver<[Pokemon]>
        let isLoading: Driver<Bool>
    }

    let input: Input
    let output: Output

    private weak var coordinator: ListPokemonCoordinator?
    private let useCase: PokemonUseCase
    private let bag = DisposeBag()

    private let activityTracker = RxActivityTracker()

    private let pokemonSubject = ReplaySubject<[Pokemon]>.create(bufferSize: 1)
    private let selectPokemonSubject = PublishSubject<Pokemon>()

    init(coordinator: ListPokemonCoordinator, useCase: PokemonUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase

        input = Input(selectPokemon: selectPokemonSubject.asObserver())
        output = Output(pokemon: pokemonSubject.asDriver(onErrorJustReturn: []), isLoading: activityTracker.asDriver())

        bind()
    }

    func bind() {
        bag << useCase.pokemons().track(activity: activityTracker).bind(to: pokemonSubject)
        selectPokemonSubject
            .subscribe(onNext: { (pokemon) in
                self.coordinator?.route(to: ListPokemonCoordinator.Path.showPokemon(pokemon))
            }).disposed(by: bag)
    }
}
