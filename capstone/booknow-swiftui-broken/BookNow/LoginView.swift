import SwiftUI

struct LoginView: View {
    @EnvironmentObject var store: Store
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()
                
                VStack(spacing: 8) {
                    Image(systemName: "building.2.crop.circle.fill")
                        .font(.system(size: 64))
                        .foregroundStyle(.blue)
                        .accessibilityIdentifier("app-logo")
                    
                    Text("BookNow")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .accessibilityIdentifier("app-title")
                    
                    Text("Hotel Room Booking")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Email Address")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        TextField("Email Address", text: $email)
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .accessibilityIdentifier("login-user")
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Password")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(.roundedBorder)
                            .accessibilityIdentifier("login-pass")
                    }
                    
                    if let error = errorMessage {
                        Text(error)
                            .font(.footnote)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                            .accessibilityIdentifier("login-error")
                    }
                    
                    Button(action: handleLogin) {
                        Text("Sign In")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .accessibilityIdentifier("login-btn")
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func handleLogin() {
        let result = store.login(email: email, pass: password)
        if result.success {
            errorMessage = nil
        } else {
            errorMessage = result.error
        }
    }
}
