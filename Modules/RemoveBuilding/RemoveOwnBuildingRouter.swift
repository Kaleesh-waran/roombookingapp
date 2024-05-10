//
//  RemoveOwnBuildingRouter.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 19/04/23.
//  
//

import Foundation
import UIKit

class RemoveOwnBuildingRouter: PresenterToRouterRemoveOwnBuildingProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = RemoveOwnBuildingViewController()
        
        let presenter: ViewToPresenterRemoveOwnBuildingProtocol & InteractorToPresenterRemoveOwnBuildingProtocol = RemoveOwnBuildingPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = RemoveOwnBuildingRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = RemoveOwnBuildingInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func toDismissTheAddMeeingController(from view: PresenterToViewRemoveOwnBuildingProtocol) {
        guard let view = view as? UIViewController else {return}
        view.dismiss(animated: true)
    }
}
