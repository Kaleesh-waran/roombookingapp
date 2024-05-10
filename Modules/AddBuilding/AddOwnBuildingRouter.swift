//
//  AddOwnBuildingRouter.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 19/04/23.
//  
//

import Foundation
import UIKit

class AddOwnBuildingRouter: PresenterToRouterAddOwnBuildingProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = AddOwnBuildingViewController()
        
        let presenter: ViewToPresenterAddOwnBuildingProtocol & InteractorToPresenterAddOwnBuildingProtocol = AddOwnBuildingPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = AddOwnBuildingRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = AddOwnBuildingInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func toDismissTheAddMeeingController(from view: PresenterToViewAddOwnBuildingProtocol) {
        
        guard let view = view as? UIViewController else {return}
        view.dismiss(animated: true)
    }
}
