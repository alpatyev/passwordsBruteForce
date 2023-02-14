import UIKit

// MARK: - String with possible password characters

extension String {
    var digits: String { return "0123456789" }
    var lowercase: String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase: String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters: String { return lowercase + uppercase }
    var printable: String { return digits + letters + punctuation }
}

// MARK: - UIView appearance extensions

extension UIView {
    func addDefaultBorders(with width: CGFloat? = nil) {
        self.clipsToBounds = true
        self.layer.borderColor = Constants.Colors.border
        self.layer.borderWidth = width ?? Constants.Layout.borderWidth
        self.layer.cornerRadius = Constants.Layout.cornerRadius
    }
}

