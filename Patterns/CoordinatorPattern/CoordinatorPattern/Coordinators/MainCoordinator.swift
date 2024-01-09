import UIKit

class MainCoordinator: Coordinator, MainViewControllerDelegate {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = MainViewController()
        vc.delegate = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func buySubscription() {
        let buyCoordinator = BuyCoordinator(navigationController: navigationController)
        childCoordinators.append(buyCoordinator)
        buyCoordinator.start()
    }

    func createAccount() {
        let vc = CreateAccountViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
}
