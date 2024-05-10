//
//  RoomBookingAppTests.swift
//  RoomBookingAppTests
//
//  Created by Kaleeshwaran.p on 18/04/23.
//

import XCTest
@testable import RoomBookingApp

final class RoomBookingAppTests: XCTestCase {

    var signInSut: SignInViewController!
    var signUpSut: SignUpViewController!
    var homeSut:   HomePageViewController!
    
    override func setUp() {
        
        super.setUp()
    }
    
    override func setUpWithError() throws {

        signInSut = SignInViewController()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        signInSut = storyboard.instantiateViewController(withIdentifier: "myVCID") as? SignInViewController
        signInSut.loadViewIfNeeded()

        signUpSut = SignUpViewController()
        signUpSut.loadViewIfNeeded()

        homeSut = HomePageViewController()
        homeSut.loadViewIfNeeded()
        
    }

    override func tearDownWithError() throws {

        signInSut = nil
    }

    func testTheSignInPageWithInvalidUserName(){

        let nav = UINavigationController(rootViewController: signInSut)

        // Given
        signInSut.usernameField.text = "Soni"
        signInSut.passwordField.text = "sojan"

        // When
        signInSut.signInButtonTapped(UIButton())

        // Then
        XCTAssertNotNil(nav.visibleViewController is UIAlertController)
    }

    func testTheSignInPageWithInvalidPassword(){

        let nav = UINavigationController(rootViewController: signInSut)

        // Given
        signInSut.usernameField.text = "Sonai"
        signInSut.passwordField.text = "something"

        // When
        signInSut.signInButtonTapped(UIButton())

        // Then
        XCTAssertNotNil(nav.visibleViewController is UIAlertController)
    }

    func testTheSignInPageWithValidUsernameAndPassword(){

        let nav = UINavigationController(rootViewController: signInSut)

        // Given
        signInSut.usernameField.text = "Sonai"
        signInSut.passwordField.text = "sojan"

        // When
        signInSut.signInButtonTapped(UIButton())

        // Then
        XCTAssertFalse(nav.visibleViewController is UIAlertController)
    }

    func testTheSignUpPageWithPassWord(){

        // Given
        signUpSut.usernameField.text = "Anything"
        signUpSut.mailIdField.text = "Anything"
        signUpSut.passwordField.text = "Something"
        signUpSut.confirmPasswordField.text = "Something"

        // When
        signUpSut.didTappedSignUpButton(UIButton())

        // Then
        XCTAssertEqual(signUpSut.passwordField.text, signUpSut.confirmPasswordField.text)

    }

    func testTheSignUpPageWithInvalidPassword(){

        let vc = UINavigationController(rootViewController: signUpSut)

        // Given
        signUpSut.passwordField.text = "Something"
        signUpSut.confirmPasswordField.text = "Anything"

        // When
        signUpSut.didTappedSignInButton(UIButton())

        // Then
        XCTAssertNotEqual(signUpSut.passwordField.text, signUpSut.confirmPasswordField.text)
        XCTAssertNotNil(vc.visibleViewController is UIAlertController)
    }

    func testTheFilterOptionInHomePage(){

        let vc = UINavigationController(rootViewController: HomePageViewController())
        homeSut.didTappedBuildingSelectionBarButtonItem(UIBarButtonItem())

        XCTAssertNotNil(vc.visibleViewController is UIAlertController)
        
    }
    
    func test_showTabBars() {
        
      // Given
      let tabBarController = DashBoardTabbarController()
      
      // When
      tabBarController.showTabBars()
      
      // Then
      XCTAssertEqual(tabBarController.viewControllers?.count, 3)
      XCTAssertTrue(tabBarController.viewControllers?[0] is HomePageViewController)
      XCTAssertTrue(tabBarController.viewControllers?[1] is AddMeetingTabBarViewController)
      XCTAssertTrue(tabBarController.viewControllers?[2] is StatusPageViewController)
      
      XCTAssertEqual(tabBarController.viewControllers?[0].tabBarItem.title, "Home")
      XCTAssertEqual(tabBarController.viewControllers?[0].tabBarItem.image, UIImage(systemName: "house"))
      XCTAssertEqual(tabBarController.viewControllers?[0].tabBarItem.tag, 1)
      XCTAssertEqual(tabBarController.viewControllers?[0].tabBarItem.accessibilityIdentifier, "HomeTab")
      
      XCTAssertEqual(tabBarController.viewControllers?[1].tabBarItem.title, "Add")
      XCTAssertEqual(tabBarController.viewControllers?[1].tabBarItem.image, UIImage(systemName: "plus"))
      XCTAssertEqual(tabBarController.viewControllers?[1].tabBarItem.tag, 2)
      XCTAssertEqual(tabBarController.viewControllers?[1].tabBarItem.accessibilityIdentifier, "AddTab")
      
      XCTAssertEqual(tabBarController.viewControllers?[2].tabBarItem.title, "Status")
      XCTAssertEqual(tabBarController.viewControllers?[2].tabBarItem.image, UIImage(systemName: "square.stack.3d.up"))
      XCTAssertEqual(tabBarController.viewControllers?[2].tabBarItem.tag, 3)
      XCTAssertEqual(tabBarController.viewControllers?[2].tabBarItem.accessibilityIdentifier, "StatusTab")
    }
    
    func testShouldSelectViewControllerReturnsFalseWhenSelectedIsSecondViewController() {
        
        let tabBarController = DashBoardTabbarController()
        let firstViewController = HomePageViewController()
        let secondViewController = AddMeetingTabBarViewController()
        
        let viewControllers = [firstViewController, secondViewController]
        tabBarController.viewControllers = viewControllers
        
        let shouldSelectViewController = tabBarController.tabBarController(tabBarController, shouldSelect: secondViewController)
        XCTAssertFalse(shouldSelectViewController)
    }
    
    func testShouldSelectViewControllerReturnsTrueWhenSelectedIsNotSecondViewController() {
        
        let tabBarController = DashBoardTabbarController()
        let firstViewController = HomePageViewController()
        let secondViewController = AddMeetingTabBarViewController()
        let thirdViewController = StatusPageViewController()
        
        let viewControllers = [firstViewController, secondViewController, thirdViewController]
        tabBarController.viewControllers = viewControllers
        
        let shouldSelectViewController = tabBarController.tabBarController(tabBarController, shouldSelect: firstViewController)
        XCTAssertTrue(shouldSelectViewController)
    }
    
    func testToShowDropDownBox() {
        
        // Given
        let viewController = HomePageViewController()
        viewController.presenter = HomePagePresenter()
        
        // When
        viewController.showDropDownBox()
        
        // Then
        let pickerView = viewController.presentedViewController?.view.subviews.first(where: { $0.accessibilityIdentifier == "pickerView" }) as? UIPickerView
        let alertController = viewController.presentedViewController as? UIAlertController
        
        XCTAssertNotNil(pickerView)
        XCTAssertNotNil(alertController)
        XCTAssertEqual(alertController?.actions.count, 2)
        XCTAssertEqual(alertController?.title, "Select a building")
        XCTAssertEqual(pickerView?.delegate as? HomePageViewController, viewController)
        XCTAssertEqual(pickerView?.dataSource as? HomePageViewController, viewController)
        
        XCTAssertEqual(alertController?.actions[0].title, "Select")
        XCTAssertEqual(alertController?.actions[1].title, "Cancel")
        XCTAssertEqual(pickerView?.numberOfComponents, 1)
        XCTAssertEqual(pickerView?.numberOfRows(inComponent: 0), viewController.presenter?.getTheNumberOfRowsInPickerView() ?? 0, "PickerView should have correct number of rows")
        }
    
    func testTableViewNumberOfRowsInSection() {
        
        // Given
        let viewController = HomePageViewController()
        let tableView = UITableView()

        // When
        let numberOfRows = viewController.tableView(tableView, numberOfRowsInSection: 0)

        // Then
        XCTAssertEqual(numberOfRows, 1)
    }
    
    func testTableViewSections() {
        
        let viewController = HomePageViewController()
        let tableView = UITableView()
        
        let presenterMock = PresenterMock()
        presenterMock.numberOfSectionsInTableView = 5
        
        viewController.presenter = presenterMock
        
        let numberOfSections = viewController.numberOfSections(in: tableView)
        
        print("The number of sections in \(numberOfSections)")
        print("The number of sections in presentermock is \(presenterMock.numberOfSectionsInTableView)")
        
        XCTAssertEqual(numberOfSections, presenterMock.numberOfSectionsInTableView)
    }
    
    func testTheTableViewCell() {
    
        let viewController = HomePageViewController()
        let tableView = UITableView()
        let indexPath = IndexPath(row: 0, section: 0)
        let presenterMock = PresenterMock()

        let myRoom = [MyRoom(roomNumber: 1),MyRoom(roomNumber: 2)]
        presenterMock.getTheNumberOfRoomsResult = myRoom
        
        viewController.presenter = presenterMock
        
        tableView.register(SPTableViewCell.self, forCellReuseIdentifier: SPTableViewCell.identifier)
        
        let returnedCell = viewController.tableView(tableView, cellForRowAt: indexPath) as? SPTableViewCell
        
        XCTAssertEqual(returnedCell?.accessibilityIdentifier, "MyTableViewCell")
        XCTAssertEqual(returnedCell?.layer.cornerRadius, 20.0)
        XCTAssertEqual(returnedCell?.cellIndexPath, indexPath)
        XCTAssertEqual(returnedCell?.rooms, presenterMock.getTheNumberOfRoomsResult)
        XCTAssertTrue(returnedCell?.delegate === viewController)
    }
    
    func testPickerViewNumberOfRows() {
        
        let viewController = HomePageViewController()
        let pickerView = UIPickerView()
      
        let presenterMock = PresenterMock()
        presenterMock.numberOfRowsInPickerViewReturnValue = 3
      
        viewController.presenter = presenterMock
        
        let numberOfRows = viewController.pickerView(pickerView, numberOfRowsInComponent: 0)
        print("The number of rows is \(numberOfRows)")
        print("The number of rows in presentermock is \(presenterMock.numberOfRowsInPickerViewReturnValue)")
        
        XCTAssertEqual(numberOfRows, presenterMock.numberOfRowsInPickerViewReturnValue)
    }
    
    func testPickerViewNumberOfComponents(){
        
        // Given
        let viewController = HomePageViewController()
        let pickerView = UIPickerView()
        
        // When
        let numberOfComponents = viewController.numberOfComponents(in: pickerView)
        
        // Then
        XCTAssertEqual(numberOfComponents, 1)
    }
    
    func testPickerViewTitleForRow(){
        
        // Given
        let viewController = HomePageViewController()
        let pickerView = UIPickerView()
        
        let rowForTheTitle: Int = 0
        let presenterMock = PresenterMock()
        presenterMock.titleForTheRespectiveRow = "Tower"
        
        viewController.presenter = presenterMock
        
        let titleForRow = viewController.pickerView(pickerView, titleForRow: rowForTheTitle, forComponent: 0)
        
        XCTAssertEqual(titleForRow, presenterMock.titleForTheRespectiveRow)
    }
}

class PresenterMock: HomePagePresenter {
    
    var numberOfRowsInPickerViewReturnValue: Int = 0
    
    var numberOfSectionsInTableView: Int = 0
    
    var getTheNumberOfRoomsResult: [MyRoom] = []
    
    var titleForTheRespectiveRow: String = ""
     
    override func getTheNumberOfRowsInPickerView() -> Int {
        
        return numberOfRowsInPickerViewReturnValue
    }
    
    override func getNumberOfSections(indexPath: Int) -> Int {
        
        return numberOfSectionsInTableView
    }
    
    override func getTheNumberOfRooms(selectedIndex: Int, index: Int) -> [MyRoom] {
        
        return getTheNumberOfRoomsResult
    }
    
    override func getTheTitleForEachRowInPickerView(row: Int) -> String {
        
        return titleForTheRespectiveRow
    }
}
