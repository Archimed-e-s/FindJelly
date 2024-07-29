import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var isUserAuth = UserDefaults.standard

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        isUserAuth.setValue(false, forKey: "isLogin") // меняя это значение мы определяем авторизован пользователь или нет
        guard let windowScene = (scene as? UIWindowScene) else { return }
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

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
