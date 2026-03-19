# ✅ ValidatorKit

[![Version](https://img.shields.io/cocoapods/v/ValidatorKit.svg?style=flat)](https://cocoapods.org/pods/ValidatorKit)
[![License](https://img.shields.io/cocoapods/l/ValidatorKit.svg?style=flat)](https://cocoapods.org/pods/ValidatorKit)
[![Platform](https://img.shields.io/cocoapods/p/ValidatorKit.svg?style=flat)](https://cocoapods.org/pods/ValidatorKit)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)

Simple and powerful input validation for iOS. Supports UIKit and SwiftUI.

---

## ✨ Features

- 📧 Email validation
- 📱 Phone number validation (international format)
- 🔐 Password validation with configurable rules
- 💪 Password strength meter
- 👤 Username validation
- 🔗 URL validation
- 💳 Credit card validation (Luhn algorithm)
- 🧩 SwiftUI `ValidatedField` with live feedback
- 🔗 Chainable String extensions

---

## 📦 Installation

```ruby
pod 'ValidatorKit', '~> 1.0.0'
```

---

## 🚀 Usage

### Basic Validation

```swift
import ValidatorKit

// Email
let result = Validator.email("user@example.com")
if result.isValid {
    print("Valid!")
} else {
    print(result.errorMessage ?? "")
}

// Phone
Validator.phone("+966501234567")

// Password
Validator.password("MyPass123!", requireSpecialChars: true)

// Username
Validator.username("ersan_q")

// URL
Validator.url("https://github.com", requireHTTPS: true)

// Credit Card
Validator.creditCard("4111 1111 1111 1111")
```

### String Extensions

```swift
"user@example.com".isValidEmail      // true
"+966501234567".isValidPhone         // true
"https://apple.com".isValidURL       // true
"MyPass123".passwordStrength         // .strong
"ersan_q".isValidUsername            // true
```

### Password Strength

```swift
let strength = Validator.passwordStrength("MyPass123!")
print(strength.label) // "Strong"
```

### SwiftUI — Live Validation

```swift
import SwiftUI
import ValidatorKit

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 16) {
            ValidatedField("Email", text: $email, placeholder: "Enter your email") {
                Validator.email($0)
            }

            ValidatedField("Password", text: $password, placeholder: "Enter your password") {
                Validator.password($0, requireSpecialChars: true)
            }

            PasswordStrengthView(password: password)
        }
        .padding()
    }
}
```

---

## ⚙️ Password Options

```swift
Validator.password(
    "mypassword",
    minLength: 8,             // default: 8
    requireUppercase: true,   // default: true
    requireLowercase: true,   // default: true
    requireNumbers: true,     // default: true
    requireSpecialChars: false // default: false
)
```

---

## 📋 Requirements

- iOS 13.0+
- Swift 5.0+
- Xcode 13+

---

## 📄 License

ValidatorKit is available under the MIT license.
