import Foundation

public class RegisterViewModel: ObservableObject {
    @Published public var email: String = ""
    @Published public var password: String = ""
    @Published public var errorMessage: String?
    @Published public var didRegister: Bool = false

    private let registerUseCase: RegisterUserUseCase

    public init(registerUseCase: RegisterUserUseCase) {
        self.registerUseCase = registerUseCase
    }

    public func register() {
        errorMessage = nil
        let user = User(email: email, password: password)
        do {
            try registerUseCase.execute(user: user)
            didRegister = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
