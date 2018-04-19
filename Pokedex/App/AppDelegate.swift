import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var coordinator: AppCoordinatorType!

    //swiftlint:disable:next line_length
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
        window = UIWindow()

        coordinator = AppCoordinator(window: window!)
        coordinator.start()

        window?.makeKeyAndVisible()
        return true
    }
}
