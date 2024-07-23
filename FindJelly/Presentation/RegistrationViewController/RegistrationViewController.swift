import UIKit

final class RegistrationViewController: UIViewController {

    // MARK: - Private properties

    private var isChanged: Bool = false

    private lazy var containerUI: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setDefaultButton(
            "Регистрация",
            R.color.primaryColor(),
            UIFont(name: "Arial-BoldMT",size: 24)
        )
        button.addTarget(self, action: #selector(authorizationButtonDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var authorizationButton: UIButton = {
        let button = UIButton()
        button.setDefaultButton(
            "Авторизация",
            R.color.secondaryColor(),
            UIFont(name: "Arial-BoldMT",size: 16)
        )
        button.addTarget(self, action: #selector(authorizationButtonDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.generateDefaultTextField(placeholder: "Email")
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.generateDefaultTextField(placeholder: "Пароль")
        textField.isSecureTextEntry = true
        return textField
    }()

    private lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.generateDefaultTextField(placeholder: "Повторить пароль")
        textField.isSecureTextEntry = true
        return textField
    }()

    private lazy var alreadyCreatedAccountButton: UIButton = {
        let button = UIButton()
        button.setDefaultButton(
            "Уже есть аккаунт?",
            R.color.primaryColor()?.withAlphaComponent(75),
            UIFont(name: "Arial",size: 14)!
        )
        button.addTarget(self, action: #selector(authorizationButtonDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.setPrimaryButton("Создать учетную запись", UIFont(name: "Arial-BoldMT", size: 14), 19)
        return button
    }()

    private lazy var forgotPassworButton: UIButton = {
        let button = UIButton()
        button.setDefaultButton("Забыли пароль?", R.color.secondaryColor(), UIFont(name: "Arial", size: 12))
        button.addTarget(self, action: #selector(forgotPasswordDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var mainView = {
        let view = UIView()
        return view
    }()

    // MARK: - Life Cycle

    override func loadView() {
        view = mainView
        view.backgroundColor = .white
        addSubviews()
        setConstraints()
    }

    // MARK: - Private Methods

    private func addSubviews() {
        view.addSubview(containerUI)
        [
            registrationButton,
            authorizationButton,
            emailTextField,
            passwordTextField,
            confirmPasswordTextField,
            alreadyCreatedAccountButton,
            createAccountButton
        ].forEach({ containerUI.addSubview( $0 ) })
    }

    private func setConstraints() {
        NSLayoutConstraint.activate(
            [
                containerUI.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                containerUI.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                containerUI.widthAnchor.constraint(equalToConstant: 279),
                containerUI.heightAnchor.constraint(equalToConstant: 290),

                registrationButton.topAnchor.constraint(equalTo: containerUI.topAnchor),
                registrationButton.leadingAnchor.constraint(equalTo: containerUI.leadingAnchor),
                registrationButton.heightAnchor.constraint(equalToConstant: 13),

                authorizationButton.topAnchor.constraint(equalTo: containerUI.topAnchor),
                authorizationButton.trailingAnchor.constraint(equalTo: containerUI.trailingAnchor),
                authorizationButton.widthAnchor.constraint(equalToConstant: 140),
                authorizationButton.heightAnchor.constraint(equalToConstant: 13),

                emailTextField.topAnchor.constraint(equalTo: registrationButton.bottomAnchor, constant: 50),
                emailTextField.leadingAnchor.constraint(equalTo: containerUI.leadingAnchor),
                emailTextField.trailingAnchor.constraint(equalTo: containerUI.trailingAnchor),
                emailTextField.heightAnchor.constraint(equalToConstant: 29),

                passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
                passwordTextField.leadingAnchor.constraint(equalTo: containerUI.leadingAnchor),
                passwordTextField.trailingAnchor.constraint(equalTo: containerUI.trailingAnchor),
                passwordTextField.heightAnchor.constraint(equalToConstant: 29),

                confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
                confirmPasswordTextField.leadingAnchor.constraint(equalTo: containerUI.leadingAnchor),
                confirmPasswordTextField.trailingAnchor.constraint(equalTo: containerUI.trailingAnchor),
                confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 29),

                alreadyCreatedAccountButton.topAnchor.constraint(equalTo: containerUI.topAnchor, constant: 210),
                alreadyCreatedAccountButton.centerXAnchor.constraint(equalTo: containerUI.centerXAnchor),
                alreadyCreatedAccountButton.heightAnchor.constraint(equalToConstant: 14),

                createAccountButton.bottomAnchor.constraint(equalTo: containerUI.bottomAnchor),
                createAccountButton.leadingAnchor.constraint(equalTo: containerUI.leadingAnchor, constant: 18),
                createAccountButton.trailingAnchor.constraint(equalTo: containerUI.trailingAnchor, constant: -18),
                createAccountButton.heightAnchor.constraint(equalToConstant: 34)
            ]
        )
    }

    @objc func authorizationButtonDidTap() {
        if isChanged == true {
            DispatchQueue.main.async {
                UIView.animate(
                    withDuration: 0.3) { [weak self] in
                        guard let self = self else { return }
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
                        NSLayoutConstraint.activate([
                            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
                            confirmPasswordTextField.leadingAnchor.constraint(equalTo: containerUI.leadingAnchor),
                            confirmPasswordTextField.trailingAnchor.constraint(equalTo: containerUI.trailingAnchor),
                            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 29)
                        ])
                        alreadyCreatedAccountButton.transform = CGAffineTransform(translationX: 0, y: 0)
                        createAccountButton.transform = CGAffineTransform(translationX: 0, y: 0)
                        forgotPassworButton.removeFromSuperview()
                        isChanged.toggle()
                    }
            }
        } else {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    guard let self = self else { return }
                    emailTextField.text = ""
                    passwordTextField.text = ""
                    confirmPasswordTextField.placeholder = ""
                    registrationButton.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                    authorizationButton.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                    registrationButton.setTitleColor(R.color.secondaryColor(), for: .normal)
                    authorizationButton.setTitleColor(R.color.primaryColor(), for: .normal)
                    emailTextField.placeholder = "Логин"
                    alreadyCreatedAccountButton.setTitle("У меня нет аккаунта", for: .normal)
                    createAccountButton.setTitle("Войти", for: .normal)
                    confirmPasswordTextField.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                    alreadyCreatedAccountButton.transform = CGAffineTransform(translationX: 0, y: -45)
                    createAccountButton.transform = CGAffineTransform(translationX: 0, y: -45)
                } completion: { [weak self] _ in
                    guard let self = self else { return }
                    confirmPasswordTextField.removeFromSuperview()
                    containerUI.addSubview(forgotPassworButton)
                    NSLayoutConstraint.activate([
                        forgotPassworButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 3),
                        forgotPassworButton.leadingAnchor.constraint(equalTo: containerUI.leadingAnchor, constant: 13),
                        forgotPassworButton.heightAnchor.constraint(equalToConstant: 12)
                    ])
                    isChanged.toggle()
                }
            }
        }
    }

    @objc func forgotPasswordDidTap() {
        print(#function)
    }
}
