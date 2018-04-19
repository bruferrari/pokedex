import RxSwift

public protocol PokemonUseCase {
    func pokemons() -> Single<[Pokemon]>
}
