import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var isUserAuth = UserDefaults.standard

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
//        isUserAuth.set(false, forKey: "isLogin")  // - return to the default registration screen when flag is false
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        let isLogin = isUserAuth.object(forKey: "isLogin") as? Bool ?? false
        if isLogin {
            let appViewController = MainTabBarController()
            self.window?.rootViewController = appViewController
            self.window?.makeKeyAndVisible()
        } else {
            let loginViewController = LoginViewController()
            self.window?.rootViewController = loginViewController
            self.window?.makeKeyAndVisible()
        }
    }
}
