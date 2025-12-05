import SwiftUI

public struct LoginView: View {
    @StateObject var vm: LoginViewModel

    @State private var showRegister = false
    @State private var navigateHome = false

    public init(vm: LoginViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }

    public var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Login").font(.largeTitle).bold()
                TextField("Email", text: $vm.email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke())
                SecureField("Password", text: $vm.password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke())
                if let error = vm.errorMessage {
                    Text(error).foregroundColor(.red)
                }
                Button(action: {
                    vm.login()
                }) {
                    if vm.isLoading {
                        ProgressView()
                    } else {
                        Text("Login")
                    }
                }
                .disabled(vm.isLoading)
                Button(action: {
                    showRegister = true
                }) {
                    Text("Register new user")
                        .underline()
                }
                NavigationLink(destination: HomeView(), isActive: $vm.isLoggedIn) {
                    EmptyView()
                }
                Spacer()
            }
            .padding()
            .sheet(isPresented: $showRegister) {
                // Provide dependencies
                let repo = CoreDataUserRepository()
                let registerUC = RegisterUserUseCaseImpl(repository: repo)
                RegisterView(vm: RegisterViewModel(registerUseCase: registerUC))
            }
        }
    }
}
