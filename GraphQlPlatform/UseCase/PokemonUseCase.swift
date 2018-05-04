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
        guard let name = name,
        let number = number,
        let image = image,
        let classification = classification,
        let types = types,
        let height = height,
        let weight = weight
        else { return nil }

        let fastAttacks = attacks?.fast?.compactMap { $0 }.map { $0.attack() }.compactMap { $0 } ?? []
        let specialAttacks = attacks?.special?.compactMap { $0 }.map { $0.attack() }.compactMap { $0 } ?? []

        return Pokemon(id: id as String,
                       number: number,
                       name: name,
                       image: image,
                       classification: classification, 
                       //swiftlint:disable:next force_cast
                       types: types as! [String],
                       height: PokemonDimension(minimum: height.minimum ?? "0", maximum: height.maximum ?? "0"),
                       weight: PokemonDimension(minimum: weight.minimum ?? "0", maximum: weight.maximum ?? "0"),
                       fastAttacks: fastAttacks,
                       specialAttacks: specialAttacks)
    }
}

extension AllPokemonQuery.Data.Pokemon.Attack.Fast {
    func attack() -> Domain.Attack? {
        guard let name = name, let type = type, let damage = damage else { return nil }
        return Attack(name: name, type: type, damage: damage)
    }
}

extension AllPokemonQuery.Data.Pokemon.Attack.Special {
    func attack() -> Domain.Attack? {
        guard let name = name, let type = type, let damage = damage else { return nil }
        return Attack(name: name, type: type, damage: damage)
    }
}




