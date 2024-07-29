import FirebaseAuth

final class AuthenticationManager {

    static let shared = AuthenticationManager()
    private init() {}

    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }

    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }

    func createUset(with model: LoginFields, completion: @escaping (ResponseCode) -> ()) {
        Auth.auth().createUser(withEmail: model.email, password: model.password) { [weak self] result, error in
            if error == nil {
                if result != nil {
                    let userId = result?.user.uid
                    completion(ResponseCode(code: 1))
                }
            } else {
                completion(ResponseCode(code: 0))
            }
        }
    }

    func confirmEmail() {
        Auth.auth().currentUser?.sendEmailVerification(completion: { error in
            if error != nil {
                print(error?.localizedDescription)
            }
        })
    }
}
