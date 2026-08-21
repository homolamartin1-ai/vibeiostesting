import SwiftUI

struct LoginView: View {
    @EnvironmentObject var store: Store
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 14) {
            Text("TechShop")
                .font(.system(size: 34, weight: .heavy))
                .foregroundColor(Color(red: 0.23, green: 0.18, blue: 0.71))
            Text("Sign in to continue")
                .foregroundColor(.gray)
                .padding(.bottom, 12)

            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
                .accessibilityIdentifier("login-email")

            // ─────────────────────────────────────────────────────────
            // BUG-001: a plain TextField shows the password in plaintext.
            // The requirement is a masked SecureField.
            // ─────────────────────────────────────────────────────────
            TextField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .accessibilityIdentifier("login-password")

            if !store.loginError.isEmpty {
                Text(store.loginError)
                    .foregroundColor(.red)
                    .accessibilityIdentifier("login-error")
            }

            // ─────────────────────────────────────────────────────────
            // BUG-016: no .accessibilityIdentifier — the login button
            // cannot be located reliably by identifier (testability).
            // The fix: .accessibilityIdentifier("login-submit").
            // ─────────────────────────────────────────────────────────
            Button {
                store.login(email: email, password: password)
            } label: {
                Text("Log In")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 0.23, green: 0.18, blue: 0.71))
                    .cornerRadius(10)
            }
            .padding(.top, 8)
        }
        .padding(24)
    }
}
