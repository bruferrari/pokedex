import UIKit

protocol CoordinatorPath: AutoEquatable { }

enum CloseTransition {
    case dismiss, pop
}

protocol CoordinatorType: class {
    var window: UIWindow! { get }
    var children: [CoordinatorType] { get set }

    init(window: UIWindow)
    func start()
    func route(to path: CoordinatorPath)
    func finish(withTransition transition: CloseTransition)

    func add(child: CoordinatorType)
    func remove(child: CoordinatorType)
    func setupAndInit(coordinator: CoordinatorType)
}

extension CoordinatorType {
    var currentViewController: UIViewController? {
        guard let rootViewController = window.rootViewController else { return nil }

        return currentViewController(rootViewController)
    }

    private func currentViewController(_ root: UIViewController) -> UIViewController? {
        if let tabBarController = root as? UITabBarController,
           let selected = tabBarController.selectedViewController {
            return currentViewController(selected)
        } else if let navigationController = root as? UINavigationController,
                  let top = navigationController.topViewController {
            return currentViewController(top)
        } else if let presented = root.presentedViewController {
            return currentViewController(presented)
        }

        return root
    }

    func add(child: CoordinatorType) {
        guard children.contains(where: { $0 === child }) == false else { return }

        children.append(child)
    }

    func remove(child: CoordinatorType) {
        guard children.isEmpty == false else { return }

        children = children.filter { $0 !== child }
    }

    func setupAndInit(coordinator: CoordinatorType) {
        add(child: coordinator)
        coordinator.start()
    }
}
