//
//  RoomBookingPageViewController.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import UIKit

protocol ViewToPresenterRoomBookingPageProtocol {
    
    var view: PresenterToViewRoomBookingPageProtocol? { get set }
    var interactor: PresenterToInteractorRoomBookingPageProtocol? { get set }
    var router: PresenterToRouterRoomBookingPageProtocol? { get set }
    
    func toDismissTheRoomBookingPageVC()
}


class RoomBookingPageViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    // MARK: - IBOutlets -
    @IBOutlet weak var organizerNameField: UITextField!
    @IBOutlet weak var buildingField: UITextField!
    @IBOutlet weak var floorField: UITextField!
    @IBOutlet weak var roomField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var startTimeField: UITextField!
    @IBOutlet weak var endTimeField: UITextField!

    // MARK: - Properties
    var presenter: ViewToPresenterRoomBookingPageProtocol?
    var floorsArray : [MyFloor] = []
    var rooms : [MyRoom] = []
    
    //MARK: - pickerview creation -
    let myPickerView : UIPickerView = {
       
        let pickerView = UIPickerView()
        pickerView.accessibilityIdentifier = "BuildingPickerView"
        pickerView.isAccessibilityElement = true
        return pickerView
    }()
    
    let floorPickerView : UIPickerView = {
        
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    let roomPickerView : UIPickerView = {
        
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    //MARK: - datepicker view creation -
    let datePickerView : UIDatePicker = {
        
        let myDatePickerView = UIDatePicker()
        myDatePickerView.datePickerMode = .date
        return myDatePickerView
    }()
    
    //MARK: - timer datePicker view -
    let timerDatePicker : UIDatePicker = {
       
        let myTimerDatePickerView = UIDatePicker()
        myTimerDatePickerView.datePickerMode = .time
        return myTimerDatePickerView
    }()
    
    let endTimerDatePicker : UIDatePicker = {
       
        let myTimerDatePickerView = UIDatePicker()
        myTimerDatePickerView.datePickerMode = .time
        return myTimerDatePickerView
    }()
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpPickerView()
        setUpDatePickerView()
        registerForKeyboardNotifications()

    }
    
    
    func setUp(){
            
        let presenter  = RoomBookingPagePresenter()
        let interactor = RoomBookingPageInteractor()
        let router     = RoomBookingPageRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = self
        
        interactor.presenter = presenter
        self.presenter = presenter
        
    }
    
    private func setUpPickerView() {
        
        myPickerView.translatesAutoresizingMaskIntoConstraints = false
        buildingField.addSubview(myPickerView)
        
        NSLayoutConstraint.activate([
            myPickerView.leadingAnchor.constraint(equalTo: buildingField.leadingAnchor),
            myPickerView.trailingAnchor.constraint(equalTo: buildingField.trailingAnchor),
            myPickerView.topAnchor.constraint(equalTo: buildingField.topAnchor),
            myPickerView.bottomAnchor.constraint(equalTo: buildingField.bottomAnchor)
        ])
        
        myPickerView.delegate = self
        myPickerView.dataSource = self
        
        floorPickerView.translatesAutoresizingMaskIntoConstraints = false
        floorField.addSubview(floorPickerView)

        NSLayoutConstraint.activate([
            floorPickerView.leadingAnchor.constraint(equalTo: floorField.leadingAnchor),
            floorPickerView.trailingAnchor.constraint(equalTo: floorField.trailingAnchor),
            floorPickerView.topAnchor.constraint(equalTo: floorField.topAnchor),
            floorPickerView.bottomAnchor.constraint(equalTo: floorField.bottomAnchor)
        ])
 

        roomPickerView.translatesAutoresizingMaskIntoConstraints = false
        roomField.addSubview(roomPickerView)

        NSLayoutConstraint.activate([
            roomPickerView.leadingAnchor.constraint(equalTo: roomField.leadingAnchor),
            roomPickerView.trailingAnchor.constraint(equalTo: roomField.trailingAnchor),
            roomPickerView.topAnchor.constraint(equalTo: roomField.topAnchor),
            roomPickerView.bottomAnchor.constraint(equalTo: roomField.bottomAnchor)
        ])

    }
    private func setUpDatePickerView(){
        
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        dateField.addSubview(datePickerView)
        
        NSLayoutConstraint.activate([
            datePickerView.leadingAnchor.constraint(equalTo: dateField.leadingAnchor),
            datePickerView.trailingAnchor.constraint(equalTo: dateField.trailingAnchor),
            datePickerView.topAnchor.constraint(equalTo: dateField.topAnchor),
            datePickerView.bottomAnchor.constraint(equalTo: dateField.bottomAnchor)
        ])
        datePickerView.accessibilityIdentifier = "datePickerView"
        
        timerDatePicker.translatesAutoresizingMaskIntoConstraints = false
        startTimeField.addSubview(timerDatePicker)
        
        NSLayoutConstraint.activate([
            timerDatePicker.leadingAnchor.constraint(equalTo: startTimeField.leadingAnchor),
            timerDatePicker.trailingAnchor.constraint(equalTo: startTimeField.trailingAnchor),
            timerDatePicker.topAnchor.constraint(equalTo: startTimeField.topAnchor),
            timerDatePicker.bottomAnchor.constraint(equalTo: startTimeField.bottomAnchor)
        ])
        
        endTimerDatePicker.translatesAutoresizingMaskIntoConstraints = false
        endTimeField.addSubview(endTimerDatePicker)
        
        NSLayoutConstraint.activate([
            endTimerDatePicker.leadingAnchor.constraint(equalTo: endTimeField.leadingAnchor),
            endTimerDatePicker.trailingAnchor.constraint(equalTo: endTimeField.trailingAnchor),
            endTimerDatePicker.topAnchor.constraint(equalTo: endTimeField.topAnchor),
            endTimerDatePicker.bottomAnchor.constraint(equalTo: endTimeField.bottomAnchor)
        ])
    }
    
    //MARK: function to Handle keyboard events
    func registerForKeyboardNotifications(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShown(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: @objc methods
    
    @objc func keyBoardWillShown(_ notification : NSNotification){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyBoardWillHide(_ notification : NSNotification){
        
        view.gestureRecognizers?.forEach({ gestureRecognizer in
            
            if gestureRecognizer is UITapGestureRecognizer {
                view.removeGestureRecognizer(gestureRecognizer)
            }
        })
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func didTappedCancelButton(_ sender: UIButton) {
        presenter?.toDismissTheRoomBookingPageVC()
    }
    
    @IBAction func didTappedAddMeetingButton(_ sender: UIButton) {
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return HomePageEntity.shared.buildings.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return HomePageEntity.shared.buildings[row].buildingName
    }
    
}

extension RoomBookingPageViewController: PresenterToViewRoomBookingPageProtocol{
    // TODO: Implement View Output Methods
}
