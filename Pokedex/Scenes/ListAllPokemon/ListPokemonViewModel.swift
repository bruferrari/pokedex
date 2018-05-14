import Foundation
import RxSwift
import RxCocoa
import Domain

struct ListPokemonViewModel: RxViewModel {
    struct Input {
        let selectPokemon: AnyObserver<Pokemon>
        let searchFilter: AnyObserver<String>
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
    private let searchFilterSubject = PublishSubject<String>()
    private let allPokemons = BehaviorRelay<[Pokemon]>(value: [])

    init(coordinator: ListPokemonCoordinator, useCase: PokemonUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase

        input = Input(selectPokemon: selectPokemonSubject.asObserver(), searchFilter: searchFilterSubject.asObserver())
        output = Output(pokemon: pokemonSubject.asDriver(onErrorJustReturn: []), isLoading: activityTracker.asDriver())

        bind()
    }

    func bind() {
        bag << useCase.pokemons().track(activity: activityTracker)
            .subscribe(onNext: {
                self.pokemonSubject.on(.next($0))
                self.allPokemons.accept($0)
            })
        selectPokemonSubject
            .subscribe(onNext: { (pokemon) in
                self.coordinator?.route(to: ListPokemonCoordinator.Path.showPokemon(pokemon))
            }).disposed(by: bag)

        bag << searchFilterSubject
            .subscribe(onNext: { (filter) in
                guard filter != "" else {
                    self.pokemonSubject.on(.next(self.allPokemons.value))
                    return
                }
                let filtered = self.allPokemons.value.filter { $0.name.lowercased().contains(filter.lowercased()) }
                self.pokemonSubject.on(.next(filtered))
            })
    }
}
