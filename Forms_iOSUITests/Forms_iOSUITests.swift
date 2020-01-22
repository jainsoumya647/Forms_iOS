//
//  Forms_iOSUITests.swift
//  Forms_iOSUITests
//
//  Created by Soumya on 20/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import XCTest

class Forms_iOSUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        self.addButtonPressed(app)
        self.sendButtonAction(app)
        self.fillTitleTextField(app)
        self.fillDescriptionTextField(app)
        self.fillBudgetTextField(app)
        self.fillRateTextField(app)
        self.fillPaymentTextField(app)
        self.fillStartDateTextField(app)
        self.fillJobTermTextField(app)
        self.sendButtonAction(app)
        let add = app.buttons["Add"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: add, handler: nil)
        waitForExpectations(timeout: 3, handler: nil)
    }

    private func addButtonPressed(_ app: XCUIApplication) {
        XCTAssertTrue(app.buttons["Add"].exists)
        app.buttons["Add"].tap()
    }

    private func fillTitleTextField(_ app: XCUIApplication) {
        XCTAssertTrue(app.textFields["Form Title"].exists)
        app.textFields["Form Title"].tap()
        app.textFields["Form Title"].typeText("Title Bro it is")
    }

    private func fillDescriptionTextField(_ app: XCUIApplication) {
        XCTAssertTrue(app.textFields["Form Description"].exists)
        app.textFields["Form Description"].tap()
        app.textFields["Form Description"].typeText("This is my Description")
    }

    private func fillBudgetTextField(_ app: XCUIApplication) {
        XCTAssertTrue(app.textFields["Budget"].exists)
        app.textFields["Budget"].tap()
        app.textFields["Budget"].typeText("12")
    }

    private func fillRateTextField(_ app: XCUIApplication) {
        XCTAssertTrue(app.textFields["Rate"].exists)
        app.textFields["Rate"].tap()
        let datePickers = XCUIApplication().pickers
        datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "Hourly Rate")
    }

    private func fillPaymentTextField(_ app: XCUIApplication) {
        XCTAssertTrue(app.textFields["Payment Method"].exists)
        app.textFields["Payment Method"].tap()
        let datePickers = XCUIApplication().pickers
        datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "Cash")
    }

    private func fillStartDateTextField(_ app: XCUIApplication) {
        XCTAssertTrue(app.textFields["Start Date"].exists)
        app.textFields["Start Date"].tap()
        let datePickers = XCUIApplication().datePickers
        datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "June")
        datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "1")
        datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2015")
    }

    private func fillJobTermTextField(_ app: XCUIApplication) {
        XCTAssertTrue(app.textFields["Job Term"].exists)
        app.textFields["Job Term"].tap()
        let datePickers = XCUIApplication().pickers
        datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "Recurring Job")
    }

    private func sendButtonAction(_ app: XCUIApplication) {
        XCTAssertTrue(app.buttons["SendButton"].exists)
        app.buttons["SendButton"].tap()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
