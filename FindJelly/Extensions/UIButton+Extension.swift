import  UIKit

extension UIButton {
    func setDefaultButton (_ setTitle: String, _ color: UIColor!, _ font: UIFont!) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(setTitle, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = .clear
        self.setTitleColor(color, for: .normal)
    }

    func setPrimaryButton (_ setTitle: String, _ font: UIFont!, _ cornerRadius: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.setTitle(setTitle, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = R.color.primaryColor()
        self.setTitleColor(.white, for: .normal)
    }

    func setPrimaryButtonWithIcon (_ icon: String, _ cornerRadius: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.setImage(UIImage(systemName: icon), for: .normal)
        self.tintColor = .white
        self.backgroundColor = R.color.primaryColor()
    }
}
