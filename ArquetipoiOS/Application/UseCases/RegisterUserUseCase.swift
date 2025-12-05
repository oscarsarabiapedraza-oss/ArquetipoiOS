import Foundation

public protocol RegisterUserUseCase {
    func execute(user: User) throws
}

public class RegisterUserUseCaseImpl: RegisterUserUseCase {
    private let repository: UserRepository

    public init(repository: UserRepository) {
        self.repository = repository
    }

    public func execute(user: User) throws {
        try repository.save(user: user)
    }
}
