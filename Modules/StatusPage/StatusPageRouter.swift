//
//  StatusPageRouter.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import Foundation
import UIKit

class StatusPageRouter: PresenterToRouterStatusPageProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = StatusPageViewController()
        
        let presenter: ViewToPresenterStatusPageProtocol & InteractorToPresenterStatusPageProtocol = StatusPagePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = StatusPageRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = StatusPageInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
