//
//  RoomBookingPageRouter.swift
//  Offiz
//
//  Created by sonai-zstch1129 on 12/04/23.
//  
//

import Foundation
import UIKit

class RoomBookingPageRouter: PresenterToRouterRoomBookingPageProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = RoomBookingPageViewController()
        
        let presenter: ViewToPresenterRoomBookingPageProtocol & InteractorToPresenterRoomBookingPageProtocol = RoomBookingPagePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = RoomBookingPageRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = RoomBookingPageInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func toDismissTheVC(from view: PresenterToViewRoomBookingPageProtocol) {
        
        guard let dismissView = view as? UIViewController else {return}
        dismissView.dismiss(animated: true)
    }
}
