//
//  AddMeetingTabBarRouter.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import Foundation
import UIKit

class AddMeetingTabBarRouter: PresenterToRouterAddMeetingTabBarProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = AddMeetingTabBarViewController()
        
        let presenter: ViewToPresenterAddMeetingTabBarProtocol & InteractorToPresenterAddMeetingTabBarProtocol = AddMeetingTabBarPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = AddMeetingTabBarRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = AddMeetingTabBarInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
