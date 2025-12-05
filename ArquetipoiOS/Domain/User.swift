import Foundation

public struct User: Identifiable, Codable, Equatable {
    public var id: UUID
    public var email: String
    public var password: String

    public init(id: UUID = UUID(), email: String, password: String) {
        self.id = id
        self.email = email
        self.password = password
    }
}
