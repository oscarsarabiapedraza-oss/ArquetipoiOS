import SwiftUI

public struct RegisterView: View {
    @StateObject var vm: RegisterViewModel
    @Environment(\.presentationMode) var presentation

    public init(vm: RegisterViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }

    public var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Register").font(.largeTitle).bold()
                TextField("Email", text: $vm.email)
                    .keyboardType(.emailAddress)
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
                    vm.register()
                    if vm.didRegister {
                        presentation.wrappedValue.dismiss()
                    }
                }) {
                    Text("Create account")
                }
                Spacer()
            }
            .padding()
        }
    }
}
