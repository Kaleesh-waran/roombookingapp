//
//  DirectRoomBookingRouter.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 21/04/23.
//  
//

import Foundation
import UIKit

class DirectRoomBookingRouter: PresenterToRouterDirectRoomBookingProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = DirectRoomBookingViewController()
        
        let presenter: ViewToPresenterDirectRoomBookingProtocol & InteractorToPresenterDirectRoomBookingProtocol = DirectRoomBookingPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = DirectRoomBookingRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = DirectRoomBookingInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func dismissThePresentedVC(from view: PresenterToViewDirectRoomBookingProtocol) {
        
        guard let dismissVC = view as? UIViewController else {return}
        dismissVC.dismiss(animated: true)
    }
}
