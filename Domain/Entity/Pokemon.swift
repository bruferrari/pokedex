public struct Pokemon: AutoEquatable {
    public let id: String
    public let number: String
    public let name: String
    public let image: String
    public let classification: String
    public let types: [String]

    public init(id: String,
                number: String,
                name: String,
                image: String,
                classification: String,
                types: [String]) {
        self.id = id
        self.number = number
        self.name = name
        self.image = image
        self.classification = classification.uppercased()
        self.types = types
    }
}
