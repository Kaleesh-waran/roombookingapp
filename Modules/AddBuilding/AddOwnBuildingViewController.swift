//
//  AddOwnBuildingViewController.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 19/04/23.
//  
//

import UIKit

protocol AddBuildingDelegate: AnyObject {
    
    func didAddBuilding()
}

protocol ViewToPresenterAddOwnBuildingProtocol {
    
    var view: PresenterToViewAddOwnBuildingProtocol? { get set }
    var interactor: PresenterToInteractorAddOwnBuildingProtocol? { get set }
    var router: PresenterToRouterAddOwnBuildingProtocol? { get set }
    
    func toDismissThePresentedController()
    
    func getTheNumberOfRowsInPickerView() -> Int
    
    func getTheTitleForEachRowInPickerView(for row: Int) -> String
    
    func addNewBuildingToTheCoreData(buildingName: String,floorNumber: Int,roomNumber: Int)
}

class AddOwnBuildingViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    // MARK: - Properties
    var presenter: ViewToPresenterAddOwnBuildingProtocol?
    
    weak var delegate: AddBuildingDelegate?
    
    private let segmentControl : UISegmentedControl = {
        
        let mySegmnetControl = UISegmentedControl(items: ["New","Existing"])
        mySegmnetControl.backgroundColor = .systemGray3
        mySegmnetControl.selectedSegmentIndex = 0
        return mySegmnetControl
    }()
    
    private let buildingTextLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Add Building Name"
        return label
    }()
    
    private let buildingTextField : UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Enter Building Name"
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 10.0
        return textField
    }()
    
    private let floorTextLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Add Floor Number"
        return label
    }()
    
    private let floorTextField : UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Enter Floor Number"
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 10.0
        return textField
    }()
    
    private let roomTextLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Add Room Number"
        return label
    }()
    
    private let roomTextField : UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Enter Room Number"
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 10.0
        return textField
    }()
    
    private let removeButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10.0
        return button
    }()
    
    private let addButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10.0
        return button
    }()
    
    private let pickerView : UIPickerView = {
        
       let myPickerView = UIPickerView()
        myPickerView.backgroundColor = .systemGray
       return myPickerView
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setUp()
        setUpSegmentControl()
        setUpBuildingComponent()
        setUpFloorComponent()
        setUpRoomComponent()
        setUpButton()
        registerForKeyboardNotifications()
        
    }

    // MARK: - Functions -
    
    //MARK: functions that relates all the file in this module
    func setUp(){
        
        let presenter  = AddOwnBuildingPresenter()
        let interactor = AddOwnBuildingInteractor()
        let router     = AddOwnBuildingRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = self
        
        interactor.presenter = presenter
        self.presenter = presenter
    }
    
   
    
    private func setUpSegmentControl(){
        
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentControl)
        
        NSLayoutConstraint.activate([
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            segmentControl.heightAnchor.constraint(equalToConstant: 45)
        ])
        segmentControl.addTarget(self, action: #selector(segmentControlTapped(_ :)), for: .valueChanged)
    }
    
    private func setUpPickerView(){
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: buildingTextField.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: buildingTextField.trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: buildingTextField.topAnchor),
            pickerView.bottomAnchor.constraint(equalTo: buildingTextField.bottomAnchor)
        ])
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    
    @objc func segmentControlTapped(_ sender : UISegmentedControl){

        if segmentControl.selectedSegmentIndex == 0 {
            
            buildingTextField.placeholder = "Enter Building Name"
            floorTextField.placeholder = "Enter Floor Number"
            roomTextField.placeholder = "Enter Room Number"
            buildingTextField.inputView = nil
            pickerView.removeFromSuperview()
        }

        else {
            setUpPickerView()
            buildingTextField.placeholder = ""
            floorTextField.placeholder = "Enter Floor Number"
            roomTextField.placeholder = "Enter Room Number"
            buildingTextField.inputView = pickerView
        }
    }
    
    private func setUpBuildingComponent(){
        
        buildingTextLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buildingTextLabel)
        
        NSLayoutConstraint.activate([
            buildingTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            buildingTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            buildingTextLabel.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 50),
            buildingTextLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        buildingTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buildingTextField)
        
        NSLayoutConstraint.activate([
            buildingTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            buildingTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            buildingTextField.topAnchor.constraint(equalTo: buildingTextLabel.bottomAnchor, constant: 15),
            buildingTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func setUpFloorComponent(){
        
        floorTextLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(floorTextLabel)
        
        NSLayoutConstraint.activate([
            floorTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            floorTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            floorTextLabel.topAnchor.constraint(equalTo: buildingTextField.bottomAnchor, constant: 30),
            floorTextLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        floorTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(floorTextField)
        
        NSLayoutConstraint.activate([
            floorTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            floorTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            floorTextField.topAnchor.constraint(equalTo: floorTextLabel.bottomAnchor, constant: 15),
            floorTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func setUpRoomComponent(){
        
        roomTextLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(roomTextLabel)
        
        NSLayoutConstraint.activate([
            roomTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            roomTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            roomTextLabel.topAnchor.constraint(equalTo: floorTextField.bottomAnchor, constant: 30),
            roomTextLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        roomTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(roomTextField)
        
        NSLayoutConstraint.activate([
            roomTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            roomTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            roomTextField.topAnchor.constraint(equalTo: roomTextLabel.bottomAnchor, constant: 15),
            roomTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func setUpButton(){
        
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(removeButton)
        
        NSLayoutConstraint.activate([
            removeButton.widthAnchor.constraint(equalToConstant: 95),
            removeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            removeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45),
            removeButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        removeButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            addButton.widthAnchor.constraint(equalToConstant: 95),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45),
            addButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    func registerForKeyboardNotifications(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyBoardWillShow(_ notification : NSNotification){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.view.frame.origin.y = 140 - keyboardSize.height
    }
    
    @objc func keyBoardWillHide(_ notification : NSNotification){
        
        view.gestureRecognizers?.forEach({ gestureRecognizer in
            if gestureRecognizer is UITapGestureRecognizer {
                view.removeGestureRecognizer(gestureRecognizer)
            }
        })
        self.view.frame.origin.y = 0
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func cancelButtonTapped(){
        
        presenter?.toDismissThePresentedController()
    }
    
    @objc func addButtonTapped(){
        
        let buildingName = buildingTextField.text ?? ""
        let floorNumber  = Int(floorTextField.text ?? "") ?? 0
        let roomNumber   = Int(roomTextField.text ?? "") ?? 0
        
        let selectedIndex = pickerView.selectedRow(inComponent: 0)
        
        _ = pickerView(pickerView, titleForRow: selectedIndex, forComponent: 0)
            
            if buildingName != "" && floorNumber > 0 && roomNumber > 0 {
                
                presenter?.addNewBuildingToTheCoreData(buildingName: buildingName, floorNumber: floorNumber, roomNumber: roomNumber)
                
                self.dismiss(animated: false) {
                    
                    self.delegate?.didAddBuilding()
                }
            }
            else {
                
                let alert = UIAlertController(title: "Error occured!", message: "Please Enter Valid details", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in print("Sonai")}))
                self.present(alert, animated: true, completion: nil)
            }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return presenter?.getTheNumberOfRowsInPickerView() ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return presenter?.getTheTitleForEachRowInPickerView(for: row)
    }
}

extension AddOwnBuildingViewController: PresenterToViewAddOwnBuildingProtocol{
    
    func sendTheValueOfNumberOfRowsInPickerView(numberOfRows: Int) -> Int {
        
        return numberOfRows
    }
    
    func sendTheValueOfTitleInPickerView(title: String) -> String {
        
        return title
    }
}
