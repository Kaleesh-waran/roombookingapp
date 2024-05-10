//
//  ProfilePageRouter.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import Foundation
import UIKit

class ProfilePageRouter: PresenterToRouterProfilePageProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = ProfilePageViewController()
        
        let presenter: ViewToPresenterProfilePageProtocol & InteractorToPresenterProfilePageProtocol = ProfilePagePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = ProfilePageRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = ProfilePageInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
