
//
//  FormListTest.swift
//  Forms_iOSTests
//
//  Created by Soumya on 22/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import XCTest
@testable import Forms_iOS

class FormListTest: XCTestCase {

    var viewModel = FormsListViewModel()


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFormInsertionAndDeletion() {
        self.viewModel.appendForms(FormModel())
        XCTAssertTrue(self.viewModel.formsCountEqualsTo(1))
        self.viewModel.appendForms(FormModel())
        self.viewModel.appendForms(FormModel())
        self.viewModel.appendForms(FormModel())
        XCTAssertTrue(self.viewModel.formsCountEqualsTo(4))
        self.viewModel.removeModel(on: 0)
        XCTAssertTrue(self.viewModel.formsCountEqualsTo(3))
        self.viewModel.removeModel(on: 0)
        self.viewModel.removeModel(on: 0)
        XCTAssertTrue(self.viewModel.formsCountEqualsTo(1))
        self.viewModel.removeModel(on: 0)
        XCTAssertTrue(self.viewModel.formsCountEqualsTo(0))
        self.viewModel.removeModel(on: 0)
        self.viewModel.removeModel(on: 0)
        XCTAssertTrue(self.viewModel.formsCountEqualsTo(0))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            self.testFormInsertionAndDeletion()
        }
    }

}
