import SwiftUI

// MARK: - SwiftUI ValidatedField
@available(iOS 15.0, *)
public struct ValidatedField: View {
    let title: String
    @Binding var text: String
    let validate: (String) -> ValidationResult
    let placeholder: String

    @State private var result: ValidationResult = .valid
    @State private var isDirty: Bool = false

    public init(
        _ title: String,
        text: Binding<String>,
        placeholder: String = "",
        validate: @escaping (String) -> ValidationResult
    ) {
        self.title = title
        self._text = text
        self.placeholder = placeholder
        self.validate = validate
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField(placeholder.isEmpty ? title : placeholder, text: $text)
                .onChange(of: text) { newValue in
                    isDirty = true
                    result = validate(newValue)
                }
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(borderColor, lineWidth: 1.5)
                )

            if isDirty, case .invalid(let reason) = result {
                Text(reason)
                    .font(.caption)
                    .foregroundColor(.red)
                    .transition(.opacity)
            }
        }
    }

    private var borderColor: Color {
        guard isDirty else { return Color(.systemGray4) }
        return result.isValid ? .green : .red
    }
}

// MARK: - PasswordStrengthView
@available(iOS 15.0, *)
public struct PasswordStrengthView: View {
    let password: String

    private var strength: PasswordStrength {
        Validator.passwordStrength(password)
    }

    public init(password: String) {
        self.password = password
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 4) {
                ForEach(0..<5) { index in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(index <= strength.rawValue ? strengthColor : Color(.systemGray5))
                        .frame(height: 4)
                }
            }
            Text(strength.label)
                .font(.caption)
                .foregroundColor(strengthColor)
        }
    }

    private var strengthColor: Color {
        switch strength {
        case .veryWeak:   return .red
        case .weak:       return .orange
        case .fair:       return .yellow
        case .strong:     return .green
        case .veryStrong: return .blue
        }
    }
}
