import SwiftUI
import ValidatorKit

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var phone = ""

    var body: some View {
        NavigationView {
            Form {
                ValidatedField("Email", text: $email, placeholder: "user@example.com") {
                    Validator.email($0)
                }
                ValidatedField("Password", text: $password, placeholder: "Min 8 chars") {
                    Validator.password($0)
                }
                PasswordStrengthView(password: password)
                ValidatedField("Phone", text: $phone, placeholder: "+966501234567") {
                    Validator.phone($0)
                }
            }
            .navigationTitle("ValidatorKit")
        }
    }
}
