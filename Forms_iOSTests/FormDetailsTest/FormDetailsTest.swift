//
//  FormDetailsTest.swift
//  Forms_iOSTests
//
//  Created by Soumya on 22/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import XCTest
@testable import Forms_iOS

class FormDetailsTest: XCTestCase {

    var viewModel = FormDetailsViewModel()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTypesFunction() {
        XCTAssertFalse(self.viewModel.getTypes().isEmpty)
    }

    func testImagesArray() {
        XCTAssertFalse(self.viewModel.getImages().isEmpty)
        XCTAssertEqual(self.viewModel.getImages().count, 1)
        self.viewModel.appendImage(image: UIImage())
        XCTAssertEqual(self.viewModel.getImages().count, 2)
    }

    func testPlaceholderText() {
        XCTAssertEqual(self.viewModel.getPlaceholderText(for: .formTitle), Text.formTitle)
        XCTAssertEqual(self.viewModel.getPlaceholderText(for: .formDescription), Text.formDescription)
        XCTAssertEqual(self.viewModel.getPlaceholderText(for: .budget), Text.budget)
        XCTAssertEqual(self.viewModel.getPlaceholderText(for: .currency), "") // no need to show floating placeholder
        XCTAssertEqual(self.viewModel.getPlaceholderText(for: .rate), Text.rate)
        XCTAssertEqual(self.viewModel.getPlaceholderText(for: .paymentMethod), Text.paymentMethod)
        XCTAssertEqual(self.viewModel.getPlaceholderText(for: .startDate), Text.startDate)
        XCTAssertEqual(self.viewModel.getPlaceholderText(for: .jobTerm), Text.jobTerm)
    }

    func testRelatedSecondaryType() {
        XCTAssertEqual(self.viewModel.getRelatedSecondaryType(for: .budget), FormDetailsTypes.currency)
        XCTAssertEqual(self.viewModel.getRelatedSecondaryType(for: .rate), FormDetailsTypes.paymentMethod)
        XCTAssertEqual(self.viewModel.getRelatedSecondaryType(for: .startDate), FormDetailsTypes.jobTerm)
        XCTAssertEqual(self.viewModel.getRelatedSecondaryType(for: .currency), nil)
        XCTAssertEqual(self.viewModel.getRelatedSecondaryType(for: .formDescription), nil)
        XCTAssertEqual(self.viewModel.getRelatedSecondaryType(for: .formTitle), nil)
        XCTAssertEqual(self.viewModel.getRelatedSecondaryType(for: .jobTerm), nil)
        XCTAssertEqual(self.viewModel.getRelatedSecondaryType(for: .paymentMethod), nil)
    }

    func testCharacterCount() {
        XCTAssertEqual(self.viewModel.getCharacterCount(for: .budget), NSIntegerMax)
        XCTAssertEqual(self.viewModel.getCharacterCount(for: .rate), NSIntegerMax)
        XCTAssertEqual(self.viewModel.getCharacterCount(for: .startDate), NSIntegerMax)
        XCTAssertEqual(self.viewModel.getCharacterCount(for: .currency), NSIntegerMax)
        XCTAssertEqual(self.viewModel.getCharacterCount(for: .formDescription), 330)
        XCTAssertEqual(self.viewModel.getCharacterCount(for: .formTitle), 50)
        XCTAssertEqual(self.viewModel.getCharacterCount(for: .jobTerm), NSIntegerMax)
        XCTAssertEqual(self.viewModel.getCharacterCount(for: .paymentMethod), NSIntegerMax)
    }

    func testPickerArray() {
        XCTAssertEqual(self.viewModel.getPickerArray(for: .budget).count, 0)
        XCTAssertEqual(self.viewModel.getPickerArray(for: .rate).count, 3)
        XCTAssertEqual(self.viewModel.getPickerArray(for: .startDate).count, 0)
        XCTAssertEqual(self.viewModel.getPickerArray(for: .currency).count, 0)
        XCTAssertEqual(self.viewModel.getPickerArray(for: .formDescription).count, 0)
        XCTAssertEqual(self.viewModel.getPickerArray(for: .formTitle).count, 0)
        XCTAssertEqual(self.viewModel.getPickerArray(for: .jobTerm).count, 4)
        XCTAssertEqual(self.viewModel.getPickerArray(for: .paymentMethod).count, 3)
    }

    func testUpdateAndSetAndValidateData() {

        XCTAssertNil(self.viewModel.validateDataAndGetForms())

        XCTAssertTrue(self.viewModel.getText(for: .startDate).isEmpty)
        self.viewModel.updateStartDate(date: Date())
        XCTAssertNotNil(self.viewModel.getText(for: .startDate))

        XCTAssertNil(self.viewModel.validateDataAndGetForms())

        XCTAssertTrue(self.viewModel.getText(for: .budget).isEmpty)
        self.viewModel.updateText(for: .budget, updatedText: "Budget")
        XCTAssertEqual(self.viewModel.getText(for: .budget), "Budget")

        XCTAssertNil(self.viewModel.validateDataAndGetForms())

        XCTAssertEqual(self.viewModel.getText(for: .currency), "US")
        self.viewModel.updateText(for: .currency, updatedText: "INR")
        XCTAssertEqual(self.viewModel.getText(for: .currency), "US")

        XCTAssertTrue(self.viewModel.getText(for: .formDescription).isEmpty)
        self.viewModel.updateText(for: .formDescription, updatedText: "Description")
        XCTAssertEqual(self.viewModel.getText(for: .formDescription), "Description")

        XCTAssertNil(self.viewModel.validateDataAndGetForms())

        XCTAssertTrue(self.viewModel.getText(for: .formTitle).isEmpty)
        self.viewModel.updateText(for: .formTitle, updatedText: "Title")
        XCTAssertEqual(self.viewModel.getText(for: .formTitle), "Title")

        XCTAssertNotNil(self.viewModel.validateDataAndGetForms())

        XCTAssertTrue(self.viewModel.getText(for: .jobTerm).isEmpty)
        self.viewModel.updateText(for: .jobTerm, updatedText: "Term")
        XCTAssertEqual(self.viewModel.getText(for: .jobTerm), "Term")

        XCTAssertTrue(self.viewModel.getText(for: .paymentMethod).isEmpty)
        self.viewModel.updateText(for: .paymentMethod, updatedText: "Cash")
        XCTAssertEqual(self.viewModel.getText(for: .paymentMethod), "Cash")

        XCTAssertTrue(self.viewModel.getText(for: .rate).isEmpty)
        self.viewModel.updateText(for: .rate, updatedText: "Fixed")
        XCTAssertEqual(self.viewModel.getText(for: .rate), "Fixed")

        XCTAssertNotNil(self.viewModel.validateDataAndGetForms())

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
