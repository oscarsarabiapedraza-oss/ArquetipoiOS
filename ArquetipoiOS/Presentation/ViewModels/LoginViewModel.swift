import Foundation
import Combine

public class LoginViewModel: ObservableObject {
    @Published public var email: String = ""
    @Published public var password: String = ""
    @Published public var isLoading: Bool = false
    @Published public var errorMessage: String?
    @Published public var isLoggedIn: Bool = false

    private let loginUseCase: LoginUseCase
    private var cancellables = Set<AnyCancellable>()

    public init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }

    public func login() {
        errorMessage = nil
        isLoading = true
        loginUseCase.execute(email: email, password: password)
            .sink { completion in
                DispatchQueue.main.async {
                    self.isLoading = false
                    if case let .failure(err) = completion {
                        self.errorMessage = err.localizedDescription
                    }
                }
            } receiveValue: { success in
                DispatchQueue.main.async {
                    self.isLoggedIn = success
                }
            }
            .store(in: &cancellables)
    }
}
