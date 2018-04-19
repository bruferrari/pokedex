import Foundation
import Nimble
import Quick
import UIKit
@testable import Pokedex

final class AppCoordinatorTypeSpec: QuickSpec {
    override func spec() {
        var coordinator: AppCoordinatorType!
        let mockedWindow = UIWindow()

        describe("AppCoordinatorType tests") {
            beforeEach {
                coordinator = AppCoordinator(window: mockedWindow)
            }

            it("coordinator correctly instantiate a new View Controller") {
                coordinator.start()
                expect(coordinator.window.rootViewController).toNot(beNil())
            }

            it("child correctly added to coordinator children") {
                let mockCoordinator = AppCoordinatorTypeMock(window: mockedWindow)
                coordinator.add(child: mockCoordinator)
                let containsChild = coordinator.children.contains(where: { $0 === mockCoordinator })

                expect(containsChild).to(equal(true))
            }

            it("child correctly removed from coordinator children") {
                let mockCoordinator = AppCoordinatorTypeMock(window: mockedWindow)
                coordinator.add(child: mockCoordinator)
                expect(coordinator.children.count).to(equal(1))
                coordinator.remove(child: mockCoordinator)
                expect(coordinator.children.count).to(equal(0))
            }

            it("currentViewController returns window's root controller") {
                coordinator.start()
                expect(coordinator.window.rootViewController).to(equal(coordinator.currentViewController))
            }
        }

        describe("AppCoordinator with Navigation Controller as root") {
            beforeEach {
                mockedWindow.rootViewController = UINavigationController(rootViewController: UIViewController())
                coordinator = AppCoordinator(window: mockedWindow)
            }

            it("currentViewController returns UINavigationController top controller") {
                let navigation = mockedWindow.rootViewController as? UINavigationController
                expect(coordinator.currentViewController).to(equal(navigation?.topViewController))
            }
        }

        describe("AppCoordinator with TabController as root") {
            beforeEach {
                let tabBar = UITabBarController()
                tabBar.viewControllers = [UIViewController()]
                mockedWindow.rootViewController = tabBar
                coordinator = AppCoordinator(window: mockedWindow)
            }

            it("currentViewController returns UITabBar selected controller") {
                let tabController = mockedWindow.rootViewController as? UITabBarController
                expect(coordinator.currentViewController).to(equal(tabController?.selectedViewController))
            }
        }
    }
}
