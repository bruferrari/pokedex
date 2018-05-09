import Domain

struct PokemonDetailViewState {
    let pokemon: Pokemon

    static var empty: PokemonDetailViewState {
        return PokemonDetailViewState(
            pokemon: Pokemon(id: "",
                             number: "",
                             name: "",
                             image: "",
                             classification: "",
                             types: [""],
                             height: PokemonDimension(minimum: "", maximum: ""),
                             weight: PokemonDimension(minimum: "", maximum: ""),
                             fastAttacks: [],
                             specialAttacks: [],
                             evolutions: [],
                             weaknesses: "",
                             resistant: "")
        )}
}
