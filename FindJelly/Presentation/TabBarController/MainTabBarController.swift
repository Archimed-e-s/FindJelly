import UIKit

class MainTabBarController: UITabBarController {

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let registrationViewController = RegistrationViewController()
        let authorizationViewController = AuthorizationViewController()
        let profileViewController = ProfileViewController()
        let chatListViewController = ChatListViewController()
        let settingsViewController = SettingsViewController()

        viewControllers = [
            generateNavigationControllers(
                rootViewController: profileViewController,
                image: R.image.user()!.resize(
                    targetSize: CGSize(
                        width: 30,
                        height: 30
                    )
                )
            ),
            generateNavigationControllers(
                rootViewController: chatListViewController,
                image: R.image.chat()!.resize(
                    targetSize: CGSize(
                        width: 30,
                        height: 30
                    )
                )
            ),
            generateNavigationControllers(
                rootViewController: settingsViewController,
                image: R.image.settings()!.resize(
                    targetSize: CGSize(
                        width: 30,
                        height: 30
                    )
                )
            )
        ]
    }

    private func generateNavigationControllers(
        rootViewController: UIViewController,
        image: UIImage
    ) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        return navigationVC
    }

}
