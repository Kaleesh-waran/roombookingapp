//
//  SPTableViewCellRouter.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 27/04/23.
//  
//

import Foundation
import UIKit

class SPTableViewCellRouter: PresenterToRouterSPTableViewCellProtocol {
    
    // MARK: Static methods
    static func createModule() -> UITableViewCell {
        
        let tableViewCell = SPTableViewCell()
        
        let presenter: ViewToPresenterSPTableViewCellProtocol & InteractorToPresenterSPTableViewCellProtocol = SPTableViewCellPresenter()
        
        tableViewCell.presenter = presenter
        tableViewCell.presenter?.router = SPTableViewCellRouter()
        tableViewCell.presenter?.view = tableViewCell
        tableViewCell.presenter?.interactor = SPTableViewCellInteractor()
        tableViewCell.presenter?.interactor?.presenter = presenter
        
        return tableViewCell
    }
    
}
