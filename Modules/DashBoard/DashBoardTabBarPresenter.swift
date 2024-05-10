//
//  DashBoardTabBarPresenter.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import Foundation

protocol PresenterToViewDashBoardTabBarProtocol {
   
}

protocol PresenterToInteractorDashBoardTabBarProtocol {
    
    var presenter: InteractorToPresenterDashBoardTabBarProtocol? { get set }
}

protocol PresenterToRouterDashBoardTabBarProtocol {
    
    func toShowTheAddMeetingVC(from view:PresenterToViewDashBoardTabBarProtocol )
}

class DashBoardTabBarPresenter: ViewToPresenterDashBoardTabBarProtocol
{
   
    // MARK: Properties
    var view: PresenterToViewDashBoardTabBarProtocol?
    var interactor: PresenterToInteractorDashBoardTabBarProtocol?
    var router: PresenterToRouterDashBoardTabBarProtocol?
    
    func toPresentTheAddMeetingVC() {
        guard let view = view else {return }
        router?.toShowTheAddMeetingVC(from: view)
    }
    
}

extension DashBoardTabBarPresenter: InteractorToPresenterDashBoardTabBarProtocol {
    
}
