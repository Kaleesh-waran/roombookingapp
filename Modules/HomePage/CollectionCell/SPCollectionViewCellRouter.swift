//
//  SPCollectionViewCellRouter.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 27/04/23.
//  
//

import Foundation
import UIKit

class SPCollectionViewCellRouter: PresenterToRouterSPCollectionViewCellProtocol {
    
    // MARK: Static methods
    static func createModule() -> UICollectionViewCell {
        
        let collectionViewCell = SPCollectionViewCell()
        
        let presenter: ViewToPresenterSPCollectionViewCellProtocol & InteractorToPresenterSPCollectionViewCellProtocol = SPCollectionViewCellPresenter()
        
        collectionViewCell.presenter = presenter
        collectionViewCell.presenter?.router = SPCollectionViewCellRouter()
        collectionViewCell.presenter?.view = collectionViewCell
        collectionViewCell.presenter?.interactor = SPCollectionViewCellInteractor()
        collectionViewCell.presenter?.interactor?.presenter = presenter
        
        return collectionViewCell
    }
    
}
