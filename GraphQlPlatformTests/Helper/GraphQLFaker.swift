import Foundation
import Fakery
@testable import GraphQlPlatform

let faker = Faker()

struct GraphQLFaker {
    static func makePokemon() -> AllPokemonQuery.Data.Pokemon {
        var pokemon = AllPokemonQuery.Data.Pokemon(snapshot: [:])
        pokemon.id = "\(faker.number.increasingUniqueId())"
        pokemon.name = faker.name.name()
        pokemon.number = String(format: "%03d", faker.number.randomInt(min: 1, max: 150))
        pokemon.image = faker.internet.url()

        return pokemon
    }
}
