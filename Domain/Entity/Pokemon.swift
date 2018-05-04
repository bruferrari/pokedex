public struct Pokemon: AutoEquatable {
    public let id: String
    public let number: String
    public let name: String
    public let image: String
    public let classification: String
    public let types: [String]
    public let height: PokemonDimension
    public let weight: PokemonDimension
    public let fastAttacks: [Attack]
    public let specialAttacks: [Attack]

    public init(id: String,
                number: String,
                name: String,
                image: String,
                classification: String,
                types: [String],
                height: PokemonDimension,
                weight: PokemonDimension,
                fastAttacks: [Attack],
                specialAttacks: [Attack]) {
        self.id = id
        self.number = number
        self.name = name
        self.image = image
        self.classification = classification.uppercased()
        self.types = types
        self.height = height
        self.weight = weight
        self.fastAttacks = fastAttacks
        self.specialAttacks = specialAttacks
    }
}
