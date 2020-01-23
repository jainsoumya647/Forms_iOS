//
//  FormListUnitTest.swift
//  Forms_iOSTests
//
//  Created by Soumya Jain on 23/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import XCTest
@testable import Forms_iOS

class FormListUnitTest: XCTestCase {

    var viewModel = FormsListViewModel()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAppendForms() {
        
        guard let count = self.viewModel.getForms()?.count else {
            return
        }
        let form = FormModel()
        form.formTitle = "Title"
        form.formDescription = "Description"
        form.budget = "1"
        form.rate = "Fixed Price"
        form.paymentMethod = "Cash"
        form.jobTerm = "No preference"
        form.numberOfViews = 2
        self.viewModel.appendForms(form)
        XCTAssertEqual(self.viewModel.getForms()?.count, count+1)
        self.viewModel.removeModel(on: 0)
        XCTAssertEqual(self.viewModel.getForms()?.count, count)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
