//
//  RoomBookingAppUITests.swift
//  RoomBookingAppUITests
//
//  Created by Kaleeshwaran.p on 18/04/23.
//

import XCTest

final class RoomBookingAppUITests: XCTestCase {

    func testTheErrorOfSignInPage(){

        let app = XCUIApplication()
        app.launch()

        let elementsQuery = app.scrollViews.otherElements

        let userNameField = elementsQuery.textFields["userNameField"]

        let passWordField = elementsQuery.secureTextFields["passWordField"]

        let signInButton = elementsQuery.buttons["signInButton"]

        let tapSwipeUpPage = elementsQuery.containing(.staticText, identifier: "Welcome Back").element

        let alertOKButton = app.alerts["Error occured!"].scrollViews.otherElements.buttons["OK"]

        userNameField.tap()
        passWordField.tap()
        tapSwipeUpPage.tap()
        signInButton.tap()
        

        XCTAssertTrue(alertOKButton.exists)
    }
    
    func testTheValidSignInPage(){
        
        let app = XCUIApplication()
        app.launch()
        
        let elementsQuery = app.scrollViews.otherElements
        
        let userNameField = elementsQuery.textFields["userNameField"]
        
        let passWordField = elementsQuery.secureTextFields["passWordField"]
        
        let tapSwipeUpPage = elementsQuery.containing(.staticText, identifier: "Welcome Back").element
        
        let signInButton = elementsQuery.buttons["signInButton"]
        
        let alertOKButton = app.alerts["Error occured!"].scrollViews.otherElements.buttons["OK"]
        
        userNameField.tap()
        userNameField.typeText("Sonai")
        passWordField.tap()
        passWordField.typeText("sojan")
        tapSwipeUpPage.tap()
        signInButton.tap()
        
        XCTAssertFalse(alertOKButton.exists)
    }
    
    func testTheFilterButton(){
        
        let app = XCUIApplication()
        app.launch()
        
        let filterButton = app.navigationBars.buttons["filterIcon"]
        
        let selectBuildingAlert = app.alerts["Select a building"]
        filterButton.tap()
        
        let pickerView = selectBuildingAlert.pickerWheels["pickerView"].exists
        
        let selectButton = selectBuildingAlert.buttons["Select"]
        
        selectButton.tap()
        
        XCTAssertFalse(pickerView)
    }
    
    func testTheTabBars(){
        
        let app = XCUIApplication()
        app.launch()
        
        let tabBar1 = app.tabBars.buttons["HomeTab"]
        
        let tabBar3 = app.tabBars.buttons["StatusTab"]
        
        tabBar1.tap()
        let homePage = app.navigationBars.staticTexts["Home"]
        XCTAssertTrue(homePage.exists)
        
        tabBar3.tap()
        let statusPage = app.staticTexts["My Status"]
        XCTAssertTrue(statusPage.exists)
    }
    
    func testTheAddMeetingTabBar(){
        
        let app = XCUIApplication()
        app.launch()
        
        let tabBar2 = app.tabBars.buttons["AddTab"]
        tabBar2.tap()
        
        let addMeetingText = app.staticTexts["Add a meeting room"]
        XCTAssertTrue(addMeetingText.exists)
        
        let cancelButton = app.buttons["CancelButton"]
        cancelButton.tap()
        
        let homePageText = app.navigationBars.staticTexts["Home"]
        XCTAssertTrue(homePageText.exists)
        
        
    }
    
    func testTheRoomBookingController(){
        
        let app = XCUIApplication()
        app.launch()
        
        let tabBar2 = app.tabBars.buttons["AddTab"]
        tabBar2.tap()
        
        let addMeetingText = app.staticTexts["Add a meeting room"]
        XCTAssertTrue(addMeetingText.exists)
        
        let organizerNameField = app.textFields["organizerNameField"]
        XCTAssertTrue(organizerNameField.isHittable)
        
        let buildingSelectionField = app.textFields["BuildingSelectionField"]
        XCTAssertTrue(buildingSelectionField.exists)
        
        let dateField = app.textFields["dateField"]
        XCTAssertTrue(dateField.exists)
        
        let datePickerView = app.datePickers["datePickerView"]
        XCTAssertTrue(datePickerView.exists)
    }
    
    func testTheBuildingFloorAndRoomInTheMainPage(){
        
        let app = XCUIApplication()
        app.launch()
        
        let tableView = app.tables["BuildingsTableView"]
        XCTAssertTrue(tableView.exists)
        
        let tableCell = tableView.cells["MyTableViewCell"]
        XCTAssertTrue(tableCell.exists)
        
        let tableCellCount = app.tables.descendants(matching: .cell).count
        XCTAssertGreaterThan(tableCellCount, 0)
    }
}



















