//
//  StatusPageViewController.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import UIKit

protocol ViewToPresenterStatusPageProtocol {
    
    var view: PresenterToViewStatusPageProtocol? { get set }
    var interactor: PresenterToInteractorStatusPageProtocol? { get set }
    var router: PresenterToRouterStatusPageProtocol? { get set }
}

class StatusPageViewController: UIViewController {
    
    var bookedValuesResult = CoreDataManager.shared.fetchBookedRooms()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)
        setUp()
        setUpTheNavTitle()
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateBookedRooms(_:)), name: NSNotification.Name("BookedRoomsUpdated"), object: nil)
    }
    
    @objc func updateBookedRooms(_ notification: Notification) {
        
        if let bookedRooms = notification.object as? ([String], [Int], [Int], [Int]) {
            
            bookedValuesResult = bookedRooms
            collectionView.reloadData()
        }
    }
    
    // MARK: - Properties
    var presenter: ViewToPresenterStatusPageProtocol?
    
    func setUp(){
        
        let presenter = StatusPagePresenter()
        let interactor = StatusPageInteractor()
        let router  = StatusPageRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = self
        
        interactor.presenter = presenter
        self.presenter = presenter
    }
    
    private func setUpTheNavTitle(){
        
        let navigationBar = UINavigationBar()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage       = UIImage()
        navigationBar.backgroundColor   = .clear
        navigationBar.isTranslucent     = true
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navigationBar)
        
        let label           = UILabel()
        label.text          = "My Status"
        label.font          = UIFont.boldSystemFont(ofSize: 28)
        let mylabel         = UIBarButtonItem(customView: label)
        let navigationItem               = UINavigationItem()
        navigationItem.leftBarButtonItem = mylabel
        navigationBar.setItems([navigationItem], animated: false)
        
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            navigationBar.heightAnchor.constraint(equalToConstant:50)
        ])
        
    }
    
    let segmentedControl: UISegmentedControl = {
        
        let segmentedControl = UISegmentedControl(items: ["BookedMeetings"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        return collectionView
    }()

}

extension StatusPageViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return bookedValuesResult.0.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell{
            
            cell.backgroundColor = .systemGray4
            cell.layer.cornerRadius = 20.0
            let roomIndex = indexPath.row
            
            if roomIndex == 0 {
                
                cell.buildingNameLabel.text = "BuildingName: - " + bookedValuesResult.0[0]
                cell.floorNumberLabel.text = "FloorNumber: - " + "\(bookedValuesResult.1[0])"
                cell.roomNumberLabel.text = "RoomNumber: - " + "\(bookedValuesResult.2[0])"
                cell.dateLabel.text = "Date: - " + "10.05.2023"
                cell.timeLabel.text = "Duration: - " + "\(bookedValuesResult.3[0])"
                cell.organizerNameLabel.text = "OrganizerName: - " + "Sonaipandi.S"
            }
            else {
                
                let recentlyBookedBuildingName = bookedValuesResult.0[roomIndex]
                cell.buildingNameLabel.text = "BuildingName: - " + recentlyBookedBuildingName
                cell.floorNumberLabel.text = "FloorNumber: - " + "\(bookedValuesResult.1[roomIndex])"
                cell.roomNumberLabel.text = "RoomNumber: - " + "\(bookedValuesResult.2[roomIndex])"
                cell.dateLabel.text = "Date: - " + "09.05.2023"
                cell.timeLabel.text = "Duration: - " + "\(bookedValuesResult.3[roomIndex])"
                cell.organizerNameLabel.text = "OrganizerName: - " + "Divagar.G"
            }
            cell.rightImageView.image = UIImage(named: "rightImage1")
            return cell
        }
        return UICollectionViewCell()
    }
    
}

extension StatusPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width - 16 * 2, height: 200)
    }
}

extension StatusPageViewController: PresenterToViewStatusPageProtocol{
    // TODO: Implement View Output Methods
}

