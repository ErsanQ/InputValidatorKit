import Foundation

// MARK: - Validator
public final class Validator {

    // MARK: - Email
    /// Validates an email address
    public static func email(_ value: String) -> ValidationResult {
        let trimmed = value.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else {
            return .invalid(reason: "Email cannot be empty.")
        }
        let regex = #"^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"#
        guard trimmed.range(of: regex, options: .regularExpression) != nil else {
            return .invalid(reason: "Invalid email format.")
        }
        return .valid
    }

    // MARK: - Phone
    /// Validates a phone number. Supports international format (+966, +1, etc.)
    public static func phone(_ value: String, allowedRegions: [String] = []) -> ValidationResult {
        let trimmed = value.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else {
            return .invalid(reason: "Phone number cannot be empty.")
        }
        // Strip spaces and dashes for validation
        let stripped = trimmed.replacingOccurrences(of: "[\\s\\-()]", with: "", options: .regularExpression)
        let regex = #"^\+?[0-9]{7,15}$"#
        guard stripped.range(of: regex, options: .regularExpression) != nil else {
            return .invalid(reason: "Invalid phone number.")
        }
        return .valid
    }

    // MARK: - Password
    /// Validates a password with configurable options
    public static func password(
        _ value: String,
        minLength: Int = 8,
        requireUppercase: Bool = true,
        requireLowercase: Bool = true,
        requireNumbers: Bool = true,
        requireSpecialChars: Bool = false
    ) -> ValidationResult {
        guard !value.isEmpty else {
            return .invalid(reason: "Password cannot be empty.")
        }
        guard value.count >= minLength else {
            return .invalid(reason: "Password must be at least \(minLength) characters.")
        }
        if requireUppercase && !value.contains(where: { $0.isUppercase }) {
            return .invalid(reason: "Password must contain at least one uppercase letter.")
        }
        if requireLowercase && !value.contains(where: { $0.isLowercase }) {
            return .invalid(reason: "Password must contain at least one lowercase letter.")
        }
        if requireNumbers && !value.contains(where: { $0.isNumber }) {
            return .invalid(reason: "Password must contain at least one number.")
        }
        if requireSpecialChars {
            let special = CharacterSet(charactersIn: "!@#$%^&*()_+-=[]{}|;':\",./<>?")
            guard value.unicodeScalars.contains(where: { special.contains($0) }) else {
                return .invalid(reason: "Password must contain at least one special character.")
            }
        }
        return .valid
    }

    // MARK: - Password Strength
    /// Returns the strength level of a password
    public static func passwordStrength(_ value: String) -> PasswordStrength {
        var score = 0
        if value.count >= 8  { score += 1 }
        if value.count >= 12 { score += 1 }
        if value.contains(where: { $0.isUppercase }) { score += 1 }
        if value.contains(where: { $0.isLowercase }) { score += 1 }
        if value.contains(where: { $0.isNumber })    { score += 1 }
        let special = CharacterSet(charactersIn: "!@#$%^&*()_+-=[]{}|;':\",./<>?")
        if value.unicodeScalars.contains(where: { special.contains($0) }) { score += 1 }

        switch score {
        case 0...1: return .veryWeak
        case 2:     return .weak
        case 3...4: return .fair
        case 5:     return .strong
        default:    return .veryStrong
        }
    }

    // MARK: - Username
    /// Validates a username (alphanumeric + underscores, no spaces)
    public static func username(
        _ value: String,
        minLength: Int = 3,
        maxLength: Int = 20
    ) -> ValidationResult {
        let trimmed = value.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else {
            return .invalid(reason: "Username cannot be empty.")
        }
        guard trimmed.count >= minLength else {
            return .invalid(reason: "Username must be at least \(minLength) characters.")
        }
        guard trimmed.count <= maxLength else {
            return .invalid(reason: "Username must be at most \(maxLength) characters.")
        }
        let regex = #"^[a-zA-Z0-9_]+$"#
        guard trimmed.range(of: regex, options: .regularExpression) != nil else {
            return .invalid(reason: "Username can only contain letters, numbers, and underscores.")
        }
        return .valid
    }

    // MARK: - URL
    /// Validates a URL string
    public static func url(_ value: String, requireHTTPS: Bool = false) -> ValidationResult {
        let trimmed = value.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else {
            return .invalid(reason: "URL cannot be empty.")
        }
        guard let url = URL(string: trimmed), url.scheme != nil, url.host != nil else {
            return .invalid(reason: "Invalid URL format.")
        }
        if requireHTTPS && url.scheme != "https" {
            return .invalid(reason: "URL must use HTTPS.")
        }
        return .valid
    }

    // MARK: - Credit Card
    /// Validates a credit card number using Luhn algorithm
    public static func creditCard(_ value: String) -> ValidationResult {
        let digits = value.replacingOccurrences(of: "[\\s\\-]", with: "", options: .regularExpression)
        guard !digits.isEmpty else {
            return .invalid(reason: "Card number cannot be empty.")
        }
        guard digits.count >= 13 && digits.count <= 19 else {
            return .invalid(reason: "Invalid card number length.")
        }
        guard digits.allSatisfy({ $0.isNumber }) else {
            return .invalid(reason: "Card number must contain only digits.")
        }
        // Luhn algorithm
        var sum = 0
        let reversedDigits = digits.reversed().enumerated()
        for (index, char) in reversedDigits {
            guard var digit = char.wholeNumberValue else { return .invalid(reason: "Invalid card number.") }
            if index % 2 == 1 {
                digit *= 2
                if digit > 9 { digit -= 9 }
            }
            sum += digit
        }
        guard sum % 10 == 0 else {
            return .invalid(reason: "Invalid card number.")
        }
        return .valid
    }

    // MARK: - Not Empty
    /// Validates that a string is not empty
    public static func notEmpty(_ value: String, fieldName: String = "This field") -> ValidationResult {
        guard !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return .invalid(reason: "\(fieldName) cannot be empty.")
        }
        return .valid
    }

    // MARK: - Length
    /// Validates string length within a range
    public static func length(_ value: String, min: Int? = nil, max: Int? = nil) -> ValidationResult {
        if let min = min, value.count < min {
            return .invalid(reason: "Must be at least \(min) characters.")
        }
        if let max = max, value.count > max {
            return .invalid(reason: "Must be at most \(max) characters.")
        }
        return .valid
    }
}
