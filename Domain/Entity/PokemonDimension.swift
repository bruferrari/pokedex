public struct PokemonDimension: AutoEquatable {
    public let minimum: String
    public let maximum: String

    public init(minimum: String, maximum: String) {
        self.minimum = minimum
        self.maximum = maximum
    }
}
