import UIKit
import GoogleSignIn
import Firebase

final class LoginViewController: UIViewController {

    // MARK: - Private properties

    private var signInButton = GIDSignInButton()
    private var checkTextFields = LoginValidationService.shared
    private var animations = LoginAnimations.shared
    private var service = AuthenticationManager.shared

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
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var authorizationButton: UIButton = {
        let button = UIButton()
        button.setDefaultButton(
            "Авторизация",
            R.color.secondaryColor(),
            UIFont(name: "Arial-BoldMT",size: 16)
        )
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.setPrimaryButton("Создать учетную запись", UIFont(name: "Arial-BoldMT", size: 14), 19)
        button.addTarget(self, action: #selector(createUserButtonDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var forgotPassworButton: UIButton = {
        let button = UIButton()
        button.setDefaultButton("Забыли пароль?", R.color.secondaryColor(), UIFont(name: "Arial", size: 12))
        button.addTarget(self, action: #selector(forgotPasswordDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Arial", size: 12)
        label.textColor = UIColor.red
        return label
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
        setGoogleSignInButton()
    }

    // MARK: - Private Methods

    private func addSubviews() {
        view.addSubview(containerUI)
        view.addSubview(signInButton)
        [
            registrationButton,
            authorizationButton,
            emailTextField,
            passwordTextField,
            confirmPasswordTextField,
            alreadyCreatedAccountButton,
            createAccountButton,
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
                createAccountButton.heightAnchor.constraint(equalToConstant: 34),

                signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                signInButton.topAnchor.constraint(equalTo: containerUI.bottomAnchor, constant: 15),
                signInButton.heightAnchor.constraint(equalToConstant: 50),
                signInButton.widthAnchor.constraint(equalToConstant: 150),

            ]
        )
    }

    private func setGoogleSignInButton() {
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.addTarget(self, action: #selector(signInGoogleDidTap), for: .touchUpInside)
        signInButton.style = .wide
    }

    // MARK: - Action

    func signInGoogle() async throws {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        print(gidSignInResult.description)
        let accessToken = gidSignInResult.user.accessToken.tokenString

        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }

    @objc func signInGoogleDidTap() {
        Task {
            do {
                try await signInGoogle()
            } catch {
                print(error)
            }
        }
    }

    @objc func loginButtonDidTap() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            animations.rollUpDownUI(
                emailTextField,
                passwordTextField,
                confirmPasswordTextField,
                registrationButton,
                authorizationButton,
                alreadyCreatedAccountButton,
                createAccountButton,
                containerUI,
                forgotPassworButton,
                informationLabel
            )
        }
    }

    @objc func createUserButtonDidTap() {
        view.addSubview(informationLabel)
        NSLayoutConstraint.activate([
            informationLabel.topAnchor.constraint(equalTo: alreadyCreatedAccountButton.topAnchor, constant: -20),
            informationLabel.centerXAnchor.constraint(equalTo: containerUI.centerXAnchor),
            informationLabel.heightAnchor.constraint(equalToConstant: 15),
            informationLabel.widthAnchor.constraint(equalToConstant: 340)
        ])
        if checkTextFields.validField(emailTextField), checkTextFields.validField(passwordTextField) {
            if passwordTextField.text == confirmPasswordTextField.text {
                print(emailTextField.text, passwordTextField.text)
                informationLabel.removeFromSuperview()
                service.createUset(with: LoginFields(email: emailTextField.text!, password: passwordTextField.text!)) { [weak self] code in
                    guard let self = self else { return }
                    switch code.code {
                    case 0:
                        print("Status code: 0 - Failed")
                    case 1:
                        print("Status code: 1 - Success")
                        service.confirmEmail()
                    default:
                        print("Status code nil")
                    }
                }

            } else {
                containerUI.addSubview(informationLabel)
                informationLabel.text = "Неверно введен повтор пароля"
                passwordTextField.backgroundColor = R.color.notValidTextFieldsColor()
                confirmPasswordTextField.backgroundColor = R.color.notValidTextFieldsColor()
            }
        } else {
            containerUI.addSubview(informationLabel)
            passwordTextField.backgroundColor = R.color.notValidTextFieldsColor()
            confirmPasswordTextField.backgroundColor = R.color.notValidTextFieldsColor()
            informationLabel.text = "Введите корректный адрес электроной почты и пароль"

        }
    }

    @objc func forgotPasswordDidTap() {
        print(#function)
    }

}
