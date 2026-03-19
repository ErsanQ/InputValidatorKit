import Foundation

// MARK: - ValidationResult
public enum ValidationResult {
    case valid
    case invalid(reason: String)

    public var isValid: Bool {
        if case .valid = self { return true }
        return false
    }

    public var errorMessage: String? {
        if case .invalid(let reason) = self { return reason }
        return nil
    }
}

// MARK: - PasswordStrength
public enum PasswordStrength: Int, Comparable {
    case veryWeak  = 0
    case weak      = 1
    case fair      = 2
    case strong    = 3
    case veryStrong = 4

    public var label: String {
        switch self {
        case .veryWeak:   return "Very Weak"
        case .weak:       return "Weak"
        case .fair:       return "Fair"
        case .strong:     return "Strong"
        case .veryStrong: return "Very Strong"
        }
    }

    public static func < (lhs: PasswordStrength, rhs: PasswordStrength) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
