import Foundation
import Firebase

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
}

struct LoginFields {
    var email: String
    var password: String
}

struct ResponseCode {
    var code: Int
}
