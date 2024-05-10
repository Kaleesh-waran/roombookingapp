//
//  SPTableViewCellViewController.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 27/04/23.
//  
//

import UIKit

protocol ViewToPresenterSPTableViewCellProtocol {
    
    var view: PresenterToViewSPTableViewCellProtocol? { get set }
    var interactor: PresenterToInteractorSPTableViewCellProtocol? { get set }
    var router: PresenterToRouterSPTableViewCellProtocol? { get set }
}

protocol MyTableViewCellDelegate : AnyObject {
    
    func bookRoom(floorIndex: Int, roomIndex: Int)
}


class SPTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var presenter: ViewToPresenterSPTableViewCellProtocol?
    
    var rooms : [MyRoom] = []
    
    var delegate : MyTableViewCellDelegate?
    
    var cellIndexPath : IndexPath?
    
    var bookedRoomsInBuilding = CoreDataManager.shared.fetchBookedRooms()
    
    var buildingTitle: String?
    
    var floorNumber: Int?
    
    static let identifier = "MyTableViewCell"
    
    // MARK: - Lifecycle Methods
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setUp()
        collectionView.register(SPCollectionViewCell.nib(), forCellWithReuseIdentifier: SPCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.accessibilityIdentifier = "MyCollectionView"
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateBookedRooms(_:)), name: NSNotification.Name("BookedRoomsUpdated"), object: nil)
    }
    
    @objc func updateBookedRooms(_ notification: Notification) {
        
        if let bookedRooms = notification.object as? ([String], [Int], [Int], [Int]) {
            
            bookedRoomsInBuilding = bookedRooms
            collectionView.reloadData()
        }
    }
    
    static func nib() -> UINib{
        
        return UINib(nibName: "MyTableViewCell", bundle: nil)
    }
    
    func setUp(){
        
        let presenter = SPTableViewCellPresenter()
        let interactor = SPTableViewCellInteractor()
        let router = SPTableViewCellRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = self
        
        interactor.presenter = presenter
        self.presenter = presenter
    }
    
    func reloadCollectionView(){
        
        collectionView.reloadData()
    }
}

extension SPTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as? SPCollectionViewCell {
            
            cell.configure(roomName: "\(rooms[indexPath.row].roomNumber)")
            cell.accessibilityIdentifier = "MyCollectionViewCell"
            cell.layer.cornerRadius = 10.0
            cell.layer.borderWidth = 2.0
            cell.backgroundColor = .clear
            
            let allRooms = indexPath.row
            
            for (index, bookedBuilding) in bookedRoomsInBuilding.0.enumerated() {
                
                if bookedBuilding == buildingTitle {
                    
                    let bookedFloors = bookedRoomsInBuilding.1[index]
                    let bookedRooms = bookedRoomsInBuilding.2[index]
                    
                    if (bookedFloors - 1) == floorNumber {
                        
                        if (bookedRooms - 1) == allRooms {
                            
                            cell.backgroundColor = .systemRed
                            cell.isUserInteractionEnabled = false
                        } else {
                            cell.backgroundColor = .clear
                            cell.isUserInteractionEnabled = true
                        }
                    }
                }
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let floorindexPath = self.cellIndexPath {
            
            self.delegate?.bookRoom(floorIndex: floorindexPath.section, roomIndex: indexPath.row)
        }
    }
    
    func configureCell() {
        
        collectionView.reloadData()
    }
}

extension SPTableViewCell: PresenterToViewSPTableViewCellProtocol{

}


