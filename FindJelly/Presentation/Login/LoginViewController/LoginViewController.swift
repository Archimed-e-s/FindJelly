import UIKit
import GoogleSignIn
import Firebase

final class LoginViewController: UIViewController {

    // MARK: - Private properties

    var isUserAuth = UserDefaults.standard
    private var signInGoogleButton = GIDSignInButton()
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

    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setPrimaryButton("Создать учетную запись", UIFont(name: "Arial-BoldMT", size: 14), 19)
        button.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)
        print("signUp")
        return button
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setPrimaryButton("Войти", UIFont(name: "Arial-BoldMT", size: 14), 19)
        button.addTarget(self, action: #selector(signInButtonDidTap), for: .touchUpInside)
        print("signUp")
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
        view.addSubview(informationLabel)
        [
            registrationButton,
            authorizationButton,
            emailTextField,
            passwordTextField,
            confirmPasswordTextField,
            alreadyCreatedAccountButton,
            signInGoogleButton,
            signUpButton
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

                signUpButton.bottomAnchor.constraint(equalTo: containerUI.bottomAnchor),
                signUpButton.leadingAnchor.constraint(equalTo: containerUI.leadingAnchor, constant: 18),
                signUpButton.trailingAnchor.constraint(equalTo: containerUI.trailingAnchor, constant: -18),
                signUpButton.heightAnchor.constraint(equalToConstant: 34),

                signInGoogleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                signInGoogleButton.topAnchor.constraint(equalTo: containerUI.bottomAnchor, constant: 15),

                informationLabel.topAnchor.constraint(equalTo: alreadyCreatedAccountButton.topAnchor, constant: -20),
                informationLabel.centerXAnchor.constraint(equalTo: containerUI.centerXAnchor),
                informationLabel.heightAnchor.constraint(equalToConstant: 15),
                informationLabel.widthAnchor.constraint(equalToConstant: 340)
            ]
        )
    }

    private func setGoogleSignInButton() {
        signInGoogleButton.translatesAutoresizingMaskIntoConstraints = false
        signInGoogleButton.addTarget(self, action: #selector(signInGoogleDidTap), for: .touchUpInside)
        view.endEditing(true)
        signInGoogleButton.style = .wide
    }

    private func signInGoogle() async throws {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken = gidSignInResult.user.accessToken.tokenString
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }

    // MARK: - Action

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
                signInButton,
                signUpButton,
                containerUI,
                forgotPassworButton,
                informationLabel
            )
        }
    }

    @objc func signUpButtonDidTap() {
        if checkTextFields.validField(emailTextField), checkTextFields.validField(passwordTextField) {
            if passwordTextField.text == confirmPasswordTextField.text {
                service.createUser(
                    with: LoginFields(
                        email: emailTextField.text!,
                        password: passwordTextField.text!)
                ) { [weak self] code in
                    guard let self = self else { return }
                    switch code {
                    case .error:
                        informationLabel.text = "Status code: 0 - Failed"
                    case .success:
                        service.confirmEmail()
                    default:
                        informationLabel.text = "Status code nil"
                    }
                }
            } else {
                informationLabel.text = "Неверно введен повтор пароля"
                passwordTextField.backgroundColor = R.color.notValidTextFieldsColor()
                confirmPasswordTextField.backgroundColor = R.color.notValidTextFieldsColor()
            }
        } else {
            informationLabel.text = "Введите корректный адрес электроной почты и пароль"
            passwordTextField.backgroundColor = R.color.notValidTextFieldsColor()
            confirmPasswordTextField.backgroundColor = R.color.notValidTextFieldsColor()
        }
    }

    @objc func signInButtonDidTap() {
        if checkTextFields.validField(emailTextField), checkTextFields.validField(passwordTextField) {
            let authData = LoginFields(email: emailTextField.text!, password: passwordTextField.text!)
            service.authInApp(authData) { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .success:
                    isUserAuth.set(true, forKey: "isLogin")
                    let mainViewController = MainTabBarController()
                    view.insertSubview(mainViewController.view, at: 2)
                    print("success")
                case .noVerify:
                    let alertController = UIAlertController(
                        title: "Верификация",
                        message: "Подтвердите адрес эл. почты, который был отпрлен на ваш email",
                        preferredStyle: .alert
                    )
                    let verifyButton = UIAlertAction(title: "Хорошо", style: .cancel)
                    alertController.addAction(verifyButton)
                    present(alertController, animated: true)
                case .error:
                    let alertController = UIAlertController(
                        title: "Упс! Что-то пошло не так...",
                        message: "Скорее всего логин или пароль были введены неверно. Пожалуйста проверьте корректность введеных данных",
                        preferredStyle: .alert
                    )
                    let verifyButton = UIAlertAction(title: "Хорошо", style: .destructive)
                    alertController.addAction(verifyButton)
                    present(alertController, animated: true)
                }
            }
        }
    }

    @objc func forgotPasswordDidTap() {
        print(#function)
    }

}
