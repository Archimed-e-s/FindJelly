import UIKit

extension UITextField {
    func generateDefaultTextField(placeholder: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 11
        self.font = UIFont(name: "Arial", size: 17)
        self.placeholder = placeholder
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: self.frame.height))
        self.leftViewMode = .always
        self.backgroundColor = R.color.textFieldsColor()
    }
}
