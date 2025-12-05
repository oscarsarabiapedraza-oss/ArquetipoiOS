import SwiftUI


@main
struct ArquetipoiOSApp: App {

    let apiClient: URLSessionLoginAPIClient
    let loginUC: LoginUseCaseImpl

    init() {
        let client = URLSessionLoginAPIClient(baseURL: Config.baseURL)
        self.apiClient = client
        self.loginUC = LoginUseCaseImpl(api: client)
    }

    var body: some Scene {
        WindowGroup {
            LoginView(vm: LoginViewModel(loginUseCase: loginUC))
        }
    }
}
