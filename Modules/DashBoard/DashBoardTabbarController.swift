//
//  DashBoardTabBarViewController.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import UIKit

protocol ViewToPresenterDashBoardTabBarProtocol {
    
    var view: PresenterToViewDashBoardTabBarProtocol? { get set }
    var interactor: PresenterToInteractorDashBoardTabBarProtocol? { get set }
    var router: PresenterToRouterDashBoardTabBarProtocol? { get set }
    
    func toPresentTheAddMeetingVC()
}


class DashBoardTabbarController: UITabBarController,UITabBarControllerDelegate {
    
    // MARK: - Properties
    var presenter: ViewToPresenterDashBoardTabBarProtocol?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        showAllUIElements()
        self.tabBar.backgroundColor = .systemBackground
        self.delegate = self
    }
    
    // MARK: - Functions -
    private func setUp(){
        
        let presenter = DashBoardTabBarPresenter()
        let interactor = DashBoardTabBarInteractor()
        let router = DashBoardTabBarRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = self
        
        interactor.presenter = presenter
        self.presenter = presenter
    }
    
    private func showAllUIElements(){
        
        setUp()
        showTabBars()
    }
    
    func showTabBars(){
        
        let tabOne = HomePageViewController()
        let tabOneBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        tabOne.tabBarItem = tabOneBarItem
        tabOneBarItem.accessibilityIdentifier = "HomeTab"
        
        let tabTwo = AddMeetingTabBarViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "Add", image: UIImage(systemName: "plus"), tag: 2)
        tabTwo.tabBarItem = tabTwoBarItem2
        tabTwoBarItem2.accessibilityIdentifier = "AddTab"
        
        let tabThree = StatusPageViewController()
        let tabThreeBarItem3 = UITabBarItem(title: "Status", image: UIImage(systemName: "square.stack.3d.up"), tag: 3)
        tabThree.tabBarItem = tabThreeBarItem3
        tabThreeBarItem3.accessibilityIdentifier = "StatusTab"
        
        self.viewControllers = [tabOne, tabTwo,tabThree]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController == self.viewControllers?[1]{
            presenter?.toPresentTheAddMeetingVC()
            return false
        }
        
        return true
    }
}

extension DashBoardTabbarController: PresenterToViewDashBoardTabBarProtocol{

    // TODO: Implement View Output Methods
}
