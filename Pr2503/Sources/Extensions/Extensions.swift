import UIKit

// MARK: - UIView appearance extensions

extension UIView {
    func addDefaultBorders(with width: CGFloat? = nil) {
        self.clipsToBounds = true
        self.layer.borderColor = Constants.Colors.border
        self.layer.borderWidth = width ?? Constants.Layout.borderWidth
        self.layer.cornerRadius = Constants.Layout.cornerRadius
    }
}

