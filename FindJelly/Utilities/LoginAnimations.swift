import UIKit

class LoginAnimations {
    static let shared = LoginAnimations()
    private init() {}
    private var isChanged: Bool = false

    func rollUpDownUI(
        _ emailTextField: UITextField,
        _ passwordTextField: UITextField,
        _ confirmPasswordTextField: UITextField,
        _ registrationButton: UIButton,
        _ authorizationButton: UIButton,
        _ alreadyCreatedAccountButton: UIButton,
        _ createAccountButton: UIButton,
        _ containerUI: UIView,
        _ forgotPassworButton: UIButton,
        _ informationLabel: UILabel
    ) {
        if isChanged == true {
        UIView.animate(withDuration: 0.3) {
            emailTextField.text = ""
            passwordTextField.text = ""
            confirmPasswordTextField.placeholder = ""
            registrationButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            authorizationButton.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            registrationButton.setTitleColor(R.color.secondaryColor(), for: .normal)
            authorizationButton.setTitleColor(R.color.primaryColor(), for: .normal)
            emailTextField.placeholder = "Логин"
            alreadyCreatedAccountButton.setTitle("У меня нет аккаунта", for: .normal)
            createAccountButton.setTitle("Войти", for: .normal)
            confirmPasswordTextField.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            alreadyCreatedAccountButton.transform = CGAffineTransform(translationX: 0, y: -45)
            createAccountButton.transform = CGAffineTransform(translationX: 0, y: -45)
            emailTextField.backgroundColor = R.color.textFieldsColor()
            passwordTextField.backgroundColor = R.color.textFieldsColor()
            confirmPasswordTextField.backgroundColor = R.color.textFieldsColor()
            informationLabel.removeFromSuperview()
        } completion: { _ in
            confirmPasswordTextField.removeFromSuperview()
            containerUI.addSubview(forgotPassworButton)
            NSLayoutConstraint.activate([
                forgotPassworButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 3),
                forgotPassworButton.leadingAnchor.constraint(equalTo: containerUI.leadingAnchor, constant: 13),
                forgotPassworButton.heightAnchor.constraint(equalToConstant: 12)
            ])
            self.isChanged.toggle()
        }
    } else {
        UIView.animate(withDuration: 0.3) {
            emailTextField.text = ""
            passwordTextField.text = ""
            confirmPasswordTextField.text = ""
            registrationButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            authorizationButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            registrationButton.setTitleColor(R.color.primaryColor(), for: .normal)
            authorizationButton.setTitleColor(R.color.secondaryColor(), for: .normal)
            confirmPasswordTextField.placeholder = "Повторить пароль"
            emailTextField.placeholder = "Emial"
            alreadyCreatedAccountButton.setTitle("Уже есть аккаунт?", for: .normal)
            createAccountButton.setTitle("Создать учетную запись", for: .normal)
            containerUI.addSubview(confirmPasswordTextField)
            confirmPasswordTextField.transform = CGAffineTransform(scaleX: 1, y: 1)
            emailTextField.backgroundColor = R.color.textFieldsColor()
            passwordTextField.backgroundColor = R.color.textFieldsColor()
            confirmPasswordTextField.backgroundColor = R.color.textFieldsColor()
            informationLabel.removeFromSuperview()
            NSLayoutConstraint.activate([
                confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
                confirmPasswordTextField.leadingAnchor.constraint(equalTo: containerUI.leadingAnchor),
                confirmPasswordTextField.trailingAnchor.constraint(equalTo: containerUI.trailingAnchor),
                confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 29)
            ])
            alreadyCreatedAccountButton.transform = CGAffineTransform(translationX: 0, y: 0)
            createAccountButton.transform = CGAffineTransform(translationX: 0, y: 0)
            forgotPassworButton.removeFromSuperview()
            self.isChanged.toggle()
            }
        }
    }
}

