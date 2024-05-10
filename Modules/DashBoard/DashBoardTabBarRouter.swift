//
//  DashBoardTabBarRouter.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import Foundation
import UIKit

class DashBoardTabBarRouter: PresenterToRouterDashBoardTabBarProtocol {
   
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = DashBoardTabbarController()
        
        let presenter: ViewToPresenterDashBoardTabBarProtocol & InteractorToPresenterDashBoardTabBarProtocol = DashBoardTabBarPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = DashBoardTabBarRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = DashBoardTabBarInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func toShowTheAddMeetingVC(from view: PresenterToViewDashBoardTabBarProtocol){
        
        guard let mainView = view as? UIViewController else {return}
        let amvc = RoomBookingPageViewController()
        amvc.modalPresentationStyle = .fullScreen
        mainView.present(amvc, animated:true)
    }
}
