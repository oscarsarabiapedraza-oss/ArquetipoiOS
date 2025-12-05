import Foundation
import Combine

public protocol LoginUseCase {
    func execute(email: String, password: String) -> AnyPublisher<Bool, Error>
}

public class LoginUseCaseImpl: LoginUseCase {
    private let api: LoginAPIClient
    public init(api: LoginAPIClient) {
        self.api = api
    }

    public func execute(email: String, password: String) -> AnyPublisher<Bool, Error> {
        return api.login(email: email, password: password)
    }
}
