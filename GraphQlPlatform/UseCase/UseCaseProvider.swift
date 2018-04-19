import Domain
import class Apollo.ApolloClient

final public class UseCaseProvider: Domain.UseCaseProvider {
    public func pokemonUseCase() -> Domain.PokemonUseCase {
        let apiUrl = URL(string: "https://graphql-pokemon.now.sh")!
        return PokemonUseCase(connection: ApolloConnection(apiUrl: apiUrl))
    }

    public init() { }
}
