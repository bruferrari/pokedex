public struct Pokemon: AutoEquatable {
    public let id: String
    public let number: String
    public let name: String
    public let image: String

    public init(id: String, number: String, name: String, image: String) {
        self.id = id
        self.number = number
        self.name = name
        self.image = image
    }
}
