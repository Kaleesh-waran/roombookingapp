//
//  AddMeetingTabBarPresenter.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import Foundation

protocol PresenterToViewAddMeetingTabBarProtocol {
   
}

protocol PresenterToInteractorAddMeetingTabBarProtocol {
    
    var presenter: InteractorToPresenterAddMeetingTabBarProtocol? { get set }
}

protocol PresenterToRouterAddMeetingTabBarProtocol {
    
}

class AddMeetingTabBarPresenter: ViewToPresenterAddMeetingTabBarProtocol
    {

    // MARK: Properties
    var view: PresenterToViewAddMeetingTabBarProtocol?
    var interactor: PresenterToInteractorAddMeetingTabBarProtocol?
    var router: PresenterToRouterAddMeetingTabBarProtocol?
}

extension AddMeetingTabBarPresenter: InteractorToPresenterAddMeetingTabBarProtocol {
    
}
