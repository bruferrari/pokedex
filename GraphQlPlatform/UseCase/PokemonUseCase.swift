import Foundation
import Domain
import RxSwift

final class PokemonUseCase: Domain.PokemonUseCase {
    private let connection: ApolloConnection

    init(connection: ApolloConnection) {
        self.connection = connection
    }

    func pokemons() -> Single<[Pokemon]> {
        let query = AllPokemonQuery()

        return connection.client.rx.fetch(query: query)
            .map { (data: AllPokemonQuery.Data) -> [Pokemon] in
                let array: [AllPokemonQuery.Data.Pokemon] = (data.pokemons ?? []).compactMap { $0 }
                return array.map { $0.pokemon() }.compactMap { $0 }
            }
    }
}

extension AllPokemonQuery.Data.Pokemon {
    func pokemon() -> Domain.Pokemon? {
        guard let name = name, let number = number, let image = image else { return nil }
        return Pokemon(id: id as String, number: number, name: name, image: image)
    }
}
