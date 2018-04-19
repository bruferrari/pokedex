import Foundation
import RxSwift

struct PokemonDetailViewModel: RxViewModel {
    struct Input {
        let close: AnyObserver<Void>
    }
    struct Output { }

    let input: Input
    let output: Output

    private weak var coordinator: PokemonDetailCoordinator?
    private let closeSubject = PublishSubject<Void>()
    private let bag = DisposeBag()

    init(coordinator: PokemonDetailCoordinator) {
        self.coordinator = coordinator

        input = Input(close: closeSubject.asObserver())
        output = Output()

        bind()
    }

    private func bind() {
        bag << closeSubject
            .subscribe(onNext: { _ in
                self.coordinator?.finish(withTransition: .dismiss)
            })
    }
}
