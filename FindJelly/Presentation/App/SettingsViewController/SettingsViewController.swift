import UIKit

final class SettingsViewController: UIViewController {

    // MARK: - Private properties

    private lazy var mainView = {
        let view = UIView()
        return view
    }()

    // MARK: - Life Cycle

    override func loadView() {
        view = mainView
        view.backgroundColor = .white
    }

    // MARK: - Public Methods

    // MARK: - Actions

    // MARK: - Private Methods
}
