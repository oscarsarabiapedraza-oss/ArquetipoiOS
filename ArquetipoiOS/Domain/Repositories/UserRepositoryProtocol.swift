import Foundation
import Combine

public protocol UserRepository {
    func save(user: User) throws
    func fetch(byEmail email: String) throws -> User?
    func fetchAll() throws -> [User]
}
