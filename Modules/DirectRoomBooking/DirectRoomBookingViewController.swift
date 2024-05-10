//
//  DirectRoomBookingViewController.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 21/04/23.
//  
//

import UIKit

protocol ViewToPresenterDirectRoomBookingProtocol {
    
    var view: PresenterToViewDirectRoomBookingProtocol? { get set }
    var interactor: PresenterToInteractorDirectRoomBookingProtocol? { get set }
    var router: PresenterToRouterDirectRoomBookingProtocol? { get set }
    
    func dismissTheBookingController()
    
    func roomBookingDetails(buildingName: String,floorNumber: Int,roomNumber: Int,duration: Int)
}

protocol DirectRoomBookingViewControllerDelegate {
    
    func updateAvailableRooms()
}

class DirectRoomBookingViewController: UIViewController {
    
    // MARK: - Properties -
    var presenter: ViewToPresenterDirectRoomBookingProtocol?
    
    private let durations = [10, 30, 45, 60]
    
    private var selectedDuration: Int?
    
    var delegate: DirectRoomBookingViewControllerDelegate?
    
    // MARK: UIElemets creation
    
    // MARK: Title creation
    private let pageTitle : UILabel = {
        
        let label = UILabel()
        label.text = "Add a meeting room"
        label.textAlignment = .center
        return label
    }()
    
    private let organizerNameLabel : UILabel = {
        
        let label = UILabel()
        label.text = "OrganizerName"
        label.textAlignment = .left
        return label
    }()
    
    private let organizerTextField : UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.backgroundColor = .systemGray6
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = .init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        return textField
    }()
    
    private let buildingNameLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Building Name"
        label.textAlignment = .left
        return label
    }()
    
    private let buildingTextField : UITextField = {
        
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.layer.borderWidth = 2.0
        return textField
    }()
    
    private let floorNameLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Floor Name"
        label.textAlignment = .left
        return label
    }()
    
    private let floorTextField : UITextField = {
        
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.layer.borderWidth = 2.0
        return textField
    }()
    
    private let roomNameLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Room Name"
        label.textAlignment = .left
        return label
    }()
    
    private let roomTextField : UITextField = {
        
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.layer.borderWidth = 2.0
        return textField
    }()
    
    private let dateLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Select Date"
        label.textAlignment = .left
        return label
    }()
    
    private let dateTextField : UITextField = {
        
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.layer.borderWidth = 2.0
        return textField
    }()
    
    private let datePicker : UIDatePicker = {
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    private let durationLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Select Duration"
        label.textAlignment = .left
        return label
    }()
    
    private let durationTextField : UITextField = {
        
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.layer.borderWidth = 2.0
        return textField
    }()
    
    private let pickerView : UIPickerView = {
        
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private let cancelButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    private let addButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    // MARK: - Lifecycle Methods -
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setUp()
        setUpAllUIElements()
    }
    
    func setValueAllElements(buildingName : String,floorNumber : Int,roomNumber : Int){
        
        self.buildingTextField.text = buildingName
        buildingTextField.isUserInteractionEnabled = false
        
        self.floorTextField.text = ("\(floorNumber)")
        floorTextField.isUserInteractionEnabled = false
        
        self.roomTextField.text = ("\(roomNumber)")
        roomTextField.isUserInteractionEnabled = false
    }
    
    // MARK: setUp function
    private func setUp(){
        
        let presenter  = DirectRoomBookingPresenter()
        let interactor = DirectRoomBookingInteractor()
        let router     = DirectRoomBookingRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = self
        
        interactor.presenter = presenter
        self.presenter = presenter
    }
    
    private func setUpAllUIElements(){
        
        setUpPageTitle()
        setUpOrganizerNameLabel()
        setUpOrganizerTextField()
        setUpBuildingNameLabel()
        setUpBuildingTextField()
        setUpFloorNameLabel()
        setUpFloorTextField()
        setUpRoomNameLabel()
        setUpRoomTextField()
        setUpDateLabel()
        setUpDatePicker()
        setUpDurationLabel()
        setUpDurationTextField()
        setUpCancelButton()
        setUpAddButton()
    }
    
    private func setUpPageTitle(){
        
        pageTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageTitle)
        
        NSLayoutConstraint.activate([
            
            pageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 30)
        ])
    }
    
    private func setUpOrganizerNameLabel(){
        
        organizerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(organizerNameLabel)
        
        NSLayoutConstraint.activate([
            
            organizerNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            organizerNameLabel.widthAnchor.constraint(equalToConstant: 150),
            organizerNameLabel.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 30),
            organizerNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpOrganizerTextField(){
        
        organizerTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(organizerTextField)
        
        NSLayoutConstraint.activate([
            
            organizerTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            organizerTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            organizerTextField.topAnchor.constraint(equalTo: organizerNameLabel.bottomAnchor,constant: 10),
            organizerTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpBuildingNameLabel(){
        
        buildingNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buildingNameLabel)
        
        NSLayoutConstraint.activate([
            
            buildingNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            buildingNameLabel.widthAnchor.constraint(equalToConstant: 150),
            buildingNameLabel.topAnchor.constraint(equalTo: organizerTextField.bottomAnchor, constant: 20),
            buildingNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpBuildingTextField(){
        
        buildingTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buildingTextField)
        
        NSLayoutConstraint.activate([
            
            buildingTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            buildingTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            buildingTextField.topAnchor.constraint(equalTo: buildingNameLabel.bottomAnchor, constant: 10),
            buildingTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpFloorNameLabel(){
        
        floorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(floorNameLabel)
        
        NSLayoutConstraint.activate([
            
            floorNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            floorNameLabel.widthAnchor.constraint(equalToConstant: 150),
            floorNameLabel.topAnchor.constraint(equalTo: buildingTextField.bottomAnchor, constant: 20),
            floorNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpFloorTextField(){
        
        floorTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(floorTextField)
        
        NSLayoutConstraint.activate([
            
            floorTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            floorTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            floorTextField.topAnchor.constraint(equalTo: floorNameLabel.bottomAnchor, constant: 10),
            floorTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpRoomNameLabel(){
        
        roomNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(roomNameLabel)
        
        NSLayoutConstraint.activate([
            
            roomNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            roomNameLabel.widthAnchor.constraint(equalToConstant: 150),
            roomNameLabel.topAnchor.constraint(equalTo: floorTextField.bottomAnchor, constant: 20),
            roomNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpRoomTextField(){
        
        roomTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(roomTextField)
        
        NSLayoutConstraint.activate([
            
            roomTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            roomTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            roomTextField.topAnchor.constraint(equalTo: roomNameLabel.bottomAnchor, constant: 10),
            roomTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpDateLabel(){
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            dateLabel.widthAnchor.constraint(equalToConstant: 150),
            dateLabel.topAnchor.constraint(equalTo: roomTextField.bottomAnchor, constant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpDatePicker(){
        
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateTextField)
        
        NSLayoutConstraint.activate([
            
            dateTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            dateTextField.widthAnchor.constraint(equalToConstant: 150),
            dateTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            dateTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        dateTextField.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            
            datePicker.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor,constant: 0),
            datePicker.trailingAnchor.constraint(equalTo: dateTextField.trailingAnchor),
            datePicker.topAnchor.constraint(equalTo: dateTextField.topAnchor, constant: 0),
            datePicker.bottomAnchor.constraint(equalTo: dateTextField.bottomAnchor)
        ])
    }
    
    private func setUpDurationLabel(){
        
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(durationLabel)
        
        NSLayoutConstraint.activate([
            
            durationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            durationLabel.widthAnchor.constraint(equalToConstant: 150),
            durationLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            durationLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpDurationTextField(){
        
        durationTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(durationTextField)
        
        NSLayoutConstraint.activate([
            
            durationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            durationTextField.widthAnchor.constraint(equalToConstant: 150),
            durationTextField.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 10),
            durationTextField.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        durationTextField.addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            
            pickerView.leadingAnchor.constraint(equalTo: durationTextField.leadingAnchor,constant: 0),
            pickerView.trailingAnchor.constraint(equalTo: durationTextField.trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: durationTextField.topAnchor, constant: 0),
            pickerView.bottomAnchor.constraint(equalTo: durationTextField.bottomAnchor)
        ])
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func setUpCancelButton(){
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            cancelButton.widthAnchor.constraint(equalToConstant: 150),
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -30),
            cancelButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        cancelButton.addTarget(self, action: #selector(didTappedCancelButton(_ :)), for: .touchUpInside)
    }
    
    private func setUpAddButton(){
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            addButton.widthAnchor.constraint(equalToConstant: 150),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -30),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        addButton.addTarget(self, action: #selector(didTappedAddButton(_ :)), for: .touchUpInside)
    }
    
    @objc private func didTappedAddButton(_ sender: UIButton){
        
        _ = organizerNameLabel.text
        let buildingName = buildingTextField.text ?? ""
        
        if let floorNumber = Int(floorTextField.text ?? ""),
           let roomNumber = Int(roomTextField.text ?? "") {
            
            _ = datePicker.date
            let duration = selectedDuration ?? durations[0]
            
            presenter?.roomBookingDetails(buildingName: buildingName, floorNumber: floorNumber, roomNumber: roomNumber, duration: duration)
            
            self.dismiss(animated: true) {
                
                self.delegate?.updateAvailableRooms()
                let bookedRooms = CoreDataManager.shared.fetchBookedRooms()
                NotificationCenter.default.post(name: NSNotification.Name("BookedRoomsUpdated"), object: bookedRooms)
            }
        }
    }
    
    @objc private func didTappedCancelButton(_ sender: UIButton){
        
        presenter?.dismissTheBookingController()
    }
}
    
extension DirectRoomBookingViewController: PresenterToViewDirectRoomBookingProtocol{
        // TODO: Implement View Output Methods
}

extension DirectRoomBookingViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return durations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(durations[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedValue = durations[row]
        selectedDuration = selectedValue
    }
    
}

