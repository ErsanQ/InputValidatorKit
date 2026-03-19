import Foundation

// MARK: - String + ValidatorKit
public extension String {

    /// Validate as email
    var isValidEmail: Bool {
        Validator.email(self).isValid
    }

    /// Validate as phone number
    var isValidPhone: Bool {
        Validator.phone(self).isValid
    }

    /// Validate as URL
    var isValidURL: Bool {
        Validator.url(self).isValid
    }

    /// Validate as credit card
    var isValidCreditCard: Bool {
        Validator.creditCard(self).isValid
    }

    /// Get password strength
    var passwordStrength: PasswordStrength {
        Validator.passwordStrength(self)
    }

    /// Validate as username
    var isValidUsername: Bool {
        Validator.username(self).isValid
    }

    /// Check if not empty
    var isNotEmpty: Bool {
        !self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
