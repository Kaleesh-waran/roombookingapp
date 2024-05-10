//
//  HomePageViewController.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import UIKit


protocol ViewToPresenterHomePageProtocol {
    
    var view: PresenterToViewHomePageProtocol? { get set }
    
    var interactor: PresenterToInteractorHomePageProtocol? { get set }
    
    var router: PresenterToRouterHomePageProtocol? { get set }
    
    func presentTheProfileViewController() //1
    
    func toGiveValueToBuildingTitleLabel() //2
    
    func getTheNumberOfRowsInPickerView() -> Int //3
    
    func getTheTitleForEachRowInPickerView(row: Int) -> String // 4
    
    func selectOption(selectedIndex: Int) // 5
    
    func getTheBuildingTextBasedOnOption(selectedIndex: Int) -> String // 6
    
    func switchToLoginViewController() // 7

    func getNumberOfSections(indexPath: Int) -> Int // 8
    
    func getTheNumberOfRooms(selectedIndex: Int,index: Int) -> [MyRoom] // 9
    
    func getTheFloor(selectedIndex: Int,index: Int) -> MyFloor // 10
}

class HomePageViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource, UITabBarControllerDelegate, MyTableViewCellDelegate {
  
    // MARK: - Properties -
    var selectedIndex = 0
    
    var model = HomePageEntity.shared
    
    // MARK: Tableview creation
    var presenter: ViewToPresenterHomePageProtocol?
    
    // MARK: BuildingtitleLabel creation
    var buildingTitleLabel : UILabel = {
        
        let myLabel = UILabel()
        myLabel.font = UIFont.boldSystemFont(ofSize: 28)
        myLabel.textAlignment = .center
        return myLabel
    }()
    
    // MARK: Add building button  creation
    private let addBuildingButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Add Building", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10.0
        button.layer.borderWidth = 2.0
        return button
    }()
    
    //MARK: Remove building button creation
    private let removeBuildingButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Remove Building", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10.0
        button.layer.borderWidth = 2.0
        return button
    }()
    
    private let tableView : UITableView = {
        
        let myTableView = UITableView()
        myTableView.backgroundColor = .systemBackground
        return myTableView
    }()
    
    let pickerView: UIPickerView = {
        
        let pickerView = UIPickerView()
        pickerView.accessibilityIdentifier = "pickerView"
        return pickerView
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUp()
        view.backgroundColor = .systemGray3
        setUpUIElements()
    }
    
    // MARK: function to setUp all the UI elements
    private func setUpUIElements(){
        
        setUpTheCustomNavBar()
        setUpBuildingTitleLabel()
        setUpBuilidngsButton()
        setUpTableView()
    }

    // MARK: function that relates all the files in this module
    private func setUp(){
        
        let presenter  = HomePagePresenter()
        let interactor = HomePageInteractor()
        let router     = HomePageRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = self
        
        interactor.presenter = presenter
        self.presenter = presenter
    }
    
    // MARK: function to set up the custom navbar
    private func setUpTheCustomNavBar(){

        let navigationBar = UINavigationBar()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.backgroundColor = .clear
        navigationBar.isTranslucent = true
        navigationBar.shadowImage = UIImage()

        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navigationBar)
        
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            navigationBar.heightAnchor.constraint(equalToConstant:50)
        ])
        
        let leftProfileBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle.fill"), style: .done, target: self, action: #selector(didTappedProfileBarButtonItem))
        
        let buildingSelectionRightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .done, target: self, action: #selector(didTappedBuildingSelectionBarButtonItem))
        buildingSelectionRightBarButtonItem.accessibilityIdentifier = "filterIcon"
        
        let signOutRightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "power"), style: .done, target: self, action: #selector(didTappedSignOutBarButtonItem))
        signOutRightBarButtonItem.tintColor = .red
        
        let label = UILabel()
        label.text = "Home"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        let mylabel = UIBarButtonItem(customView: label)

        let navigationItem = UINavigationItem()
        navigationItem.leftBarButtonItems = [leftProfileBarButtonItem,mylabel]
        navigationItem.rightBarButtonItems = [signOutRightBarButtonItem,buildingSelectionRightBarButtonItem]
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    // MARK: Function to set up the building title label
    private func setUpBuildingTitleLabel(){

        presenter?.toGiveValueToBuildingTitleLabel()
        
        buildingTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buildingTitleLabel)
        
        NSLayoutConstraint.activate([
            
            buildingTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            buildingTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            buildingTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            buildingTitleLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
   
    // MARK: function to set up the add building button and remove building button
    private func setUpBuilidngsButton(){
        
        addBuildingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addBuildingButton)
        
        NSLayoutConstraint.activate([
            
            addBuildingButton.topAnchor.constraint(equalTo: buildingTitleLabel.bottomAnchor,constant: 15),
            addBuildingButton.heightAnchor.constraint(equalToConstant: 45),
            addBuildingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            addBuildingButton.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        addBuildingButton.addTarget(self, action: #selector(didTappedAddBuildingButton(_ :)), for: .touchUpInside)
        
        removeBuildingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(removeBuildingButton)
        
        NSLayoutConstraint.activate([
            removeBuildingButton.topAnchor.constraint(equalTo: buildingTitleLabel.bottomAnchor,constant: 15),
            removeBuildingButton.heightAnchor.constraint(equalToConstant: 45),
            removeBuildingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            removeBuildingButton.widthAnchor.constraint(equalToConstant: 150)
            
        ])
        
        removeBuildingButton.addTarget(self, action: #selector(didTappedRemoveBuildingButton(_ :)), for: .touchUpInside)
    }
    
    // MARK: Function to set up the tableview
    private func setUpTableView(){
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: buildingTitleLabel.bottomAnchor, constant: 60),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -30)
        ])
        
        tableView.register(SPTableViewCell.nib(), forCellReuseIdentifier: SPTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.accessibilityIdentifier = "BuildingsTableView"
    }
    
    // MARK: Function to reload the tableview amd update the buildingtitlelabel text
    func selectOption(option: String){
        
        buildingTitleLabel.text = option
        presenter?.selectOption(selectedIndex: selectedIndex)
        tableView.reloadData()
    }
    
    // MARK: Function to show the dropdown box when tap the filter button
    func showDropDownBox(){
               
        let alertController = UIAlertController(title: "Select a building", message: nil, preferredStyle: .alert)
        alertController.view.addSubview(pickerView)

        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            pickerView.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 50),
            pickerView.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor, constant: -50),
            pickerView.widthAnchor.constraint(equalToConstant: 270)
        ])
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        if selectedIndex > 0 {
           
            pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
        }
        
        let selectAction = UIAlertAction(title: "Select", style: .default){ (action) in
            
            let selectedIndex = self.pickerView.selectedRow(inComponent: 0)
            self.selectedIndex = selectedIndex
            self.selectOption(option: self.presenter?.getTheBuildingTextBasedOnOption(selectedIndex: selectedIndex) ?? "")
            
        }
        
        alertController.addAction(selectAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }
    
    func reloadTheData(){
      
        pickerView.reloadAllComponents()
    }
    
    // MARK: Trigger when profile barbuttonitem is tapped
    @objc func didTappedProfileBarButtonItem(_ sender : UIBarButtonItem){
        
        presenter?.presentTheProfileViewController()
    }
    
    // MARK: Trigger when filter barbuttonitem is tapped
    @objc func didTappedBuildingSelectionBarButtonItem(_ sender :UIBarButtonItem){

        showDropDownBox()
    }
    
    // MARK: Trigger when signout barbuttonitem is tapped
    @objc private func didTappedSignOutBarButtonItem(_ sender : UIBarButtonItem){

        UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
        presenter?.switchToLoginViewController()
    }
    
    // MARK: Trigger when add building button is tapped
    @objc func didTappedAddBuildingButton(_ sender : UIButton){
        
        let addBuildingViewController = AddOwnBuildingViewController()
        addBuildingViewController.modalPresentationStyle = .automatic
        addBuildingViewController.delegate = self
        self.present(addBuildingViewController, animated: true)
    }
    
    // MARK: Trigger when remove building button is tapped
    @objc func didTappedRemoveBuildingButton(_ sender : UIButton){
 
        let removeBuildingVC = RemoveOwnBuildingViewController()
        removeBuildingVC.modalPresentationStyle = .automatic
        removeBuildingVC.delegate = self
        self.present(removeBuildingVC, animated: true)
    }
   

    // MARK: Pickerview datasource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return presenter?.getTheNumberOfRowsInPickerView() ?? 0
    }
    
    // MARK: pickerview delegate method
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return presenter?.getTheTitleForEachRowInPickerView(row: row)
    }
    
    // MARK: function to present the booking viewcontroller
    func bookRoom(floorIndex: Int, roomIndex: Int) {

        let floor = presenter?.getTheFloor(selectedIndex: selectedIndex,index: floorIndex)
        let bookVC = DirectRoomBookingViewController()
        bookVC.modalPresentationStyle = .fullScreen
        bookVC.setValueAllElements(buildingName: buildingTitleLabel.text ?? "", floorNumber: floor?.floorNumber ?? 0, roomNumber: floor?.rooms[roomIndex].roomNumber ?? 0)
        bookVC.delegate = self
        self.present(bookVC, animated: true)
    }
}

extension HomePageViewController: PresenterToViewHomePageProtocol{
    
    func sendTheValueToUpdateTheView(buildingText: String) { //2
        
        buildingTitleLabel.text = buildingText
    }
    
    func sendBuildingCountToPickerView(numberOfRows: Int) -> Int { // 3
        
         return numberOfRows
    }
    
    func sendBuildingNameForRowInPickerView(buildingName: String) -> String { // 4
        
        return buildingName
    }
    
    func sendTheBuildingNameBasedOnOption(buildingName: String) -> String { // 6
        
        return buildingName
    }
    
    func sendTheFloorArrayToView(floorArray: [MyFloor]) -> [MyFloor] { // 5
        
        return floorArray
    }
    
    func sendTheSectionCountToTableView(count: Int) -> Int { // 8
        
        return count
    }
    
    func sendTheRoomToTheView(room: [MyRoom]) -> [MyRoom] { // 9
        
        return room
    }
    
    func sendTheFloorToTheView(floor: MyFloor) -> MyFloor { //10
         
        return floor
    }
 
}

extension HomePageViewController : UITableViewDelegate,UITableViewDataSource {
    
    // MARK: tableview datasource methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: SPTableViewCell.identifier, for: indexPath) as? SPTableViewCell {
            
            cell.buildingTitle = buildingTitleLabel.text
            cell.floorNumber = indexPath.section
            cell.layer.cornerRadius = 20.0
            cell.delegate = self
            cell.rooms = presenter?.getTheNumberOfRooms(selectedIndex: selectedIndex, index: indexPath.row) ?? []
            cell.cellIndexPath = indexPath
            cell.configureCell()
            cell.accessibilityIdentifier = "MyTableViewCell"
            return cell
        }
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return presenter?.getNumberOfSections(indexPath: selectedIndex) ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title : String = ""
        
        switch section {
            
        case 0:
            title = "Ground Floor"
        case 1:
            title = "First Floor"
        case 2:
            title = "Second Floor"
        case 3:
            title = "Third Floor"
        case 4:
            title = "Fourth Floor"
        case 5:
            title = "Fifth Floor"
        case 6:
            title = "Sixth Floor"
        case 7:
            title = "Seventh Floor"
        case 8:
            title = "Eight Floor"
        case 9:
            title = "Nine Floor"
        case 10:
            title = "Ten Floor"
        case 11:
            title = "Eleventh Floor"
        case 12:
            title = "Twelfth Floor"
        default:
            title = "Ground Floor"
        }
       
        return title
    }
    
    // MARK: tableview delegate methods
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
    
}

extension HomePageViewController: DirectRoomBookingViewControllerDelegate {

    func updateAvailableRooms() {

        tableView.reloadData()
    }
}

extension HomePageViewController: AddBuildingDelegate {
    
    func didAddBuilding() {
        
        model.buildings = CoreDataManager.shared.fetchAvailableBuildings()
        reloadTheData()
    }
}

extension HomePageViewController: RemoveBuildingDelegate {
    
    func didRemoveBuilding() {
        
        model.buildings = CoreDataManager.shared.fetchAvailableBuildings()
        reloadTheData()
    }
}
