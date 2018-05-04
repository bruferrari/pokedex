public struct Attack: AutoEquatable {
    public let name: String
    public let type: String
    public let damage: Int

    public init(name: String, type: String, damage: Int) {
        self.name = name
        self.type = type
        self.damage = damage
    }
}
