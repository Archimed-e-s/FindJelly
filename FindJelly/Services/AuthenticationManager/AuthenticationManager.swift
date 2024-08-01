import Firebase
import FirebaseFirestore

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

    func createUser(with model: LoginFields, completion: @escaping (ResponseCode) -> Void) {
        Auth.auth().createUser(withEmail: model.email, password: model.password) { result, error in
            if error == nil {
                if result != nil {
                    let userId = result?.user.uid
                    let email = model.email
                    let data: [String : Any] = ["email": email]
                    Firestore.firestore().collection("Users").document(userId!).setData(data)
                    completion(.success)
                }
            } else {
                completion(.error)
            }
        }
    }

    func authInApp(_ data: LoginFields, completion: @escaping (ResponseCode) -> Void) {
        Auth.auth().signIn(withEmail: data.email, password: data.password) { result, error in
            if error != nil {
                completion(.error)
            } else {
                if let result = result {
                    if result.user.isEmailVerified {
                        completion(.success)
                    } else {
                        self.confirmEmail()
                        completion(.noVerify)
                    }
                }
            }
        }
    }

    func confirmEmail() {
        Auth.auth().currentUser?.sendEmailVerification(completion: { error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
        })
    }
}
