//
//  SPCollectionViewCellViewController.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 27/04/23.
//  
//

import UIKit

protocol ViewToPresenterSPCollectionViewCellProtocol {
    
    var view: PresenterToViewSPCollectionViewCellProtocol? { get set }
    var interactor: PresenterToInteractorSPCollectionViewCellProtocol? { get set }
    var router: PresenterToRouterSPCollectionViewCellProtocol? { get set }
}

class SPCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var presenter: ViewToPresenterSPCollectionViewCellProtocol?
    
    static let identifier = "MyCollectionViewCell"
    
    @IBOutlet weak var roomName: UILabel!
    
    // MARK: - Lifecycle Methods
    override class func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    // MARK: Static function 
    static func nib() -> UINib{
        
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    
    // MARK: Function that relates all the file in this module
    func setUp(){
        
        let presenter = SPCollectionViewCellPresenter()
        let interactor = SPCollectionViewCellInteractor()
        let router = SPCollectionViewCellRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = self
        
        interactor.presenter = presenter
        self.presenter = presenter
        
    }
    
    func configure(roomName: String) {
        
        self.roomName.text = roomName
    }
    
}

extension SPCollectionViewCell: PresenterToViewSPCollectionViewCellProtocol{
    // TODO: Implement View Output Methods
}
