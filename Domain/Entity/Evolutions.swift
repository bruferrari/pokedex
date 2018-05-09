public struct Evolutions: AutoEquatable {
    public let name: String
    public let image: String

    public init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
