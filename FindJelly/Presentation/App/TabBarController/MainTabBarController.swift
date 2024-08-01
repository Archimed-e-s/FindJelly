import UIKit

class MainTabBarController: UITabBarController {

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginViewController = LoginViewController()
        let photoEditingViewController = PhotoEditingViewController()
        let settingsViewController = SettingsViewController()

        viewControllers = [
            generateNavigationControllers(
                rootViewController: photoEditingViewController,
                image: R.image.user()!.resize(
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
        UITabBar.appearance().unselectedItemTintColor = R.color.secondaryColor()
        UITabBar.appearance().tintColor = R.color.primaryColor()
        return navigationVC
    }

}
