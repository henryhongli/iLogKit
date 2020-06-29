//
//  iLogKit_ExampleUITests.swift
//  iLogKit_ExampleUITests
//
//  Created by 洪利 on 2020/6/29.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest

class iLogKit_ExampleUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["登录日志收集"]/*[[".buttons[\"登录日志收集\"].staticTexts[\"登录日志收集\"]",".staticTexts[\"登录日志收集\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["登录失败日志收集"]/*[[".buttons[\"登录失败日志收集\"].staticTexts[\"登录失败日志收集\"]",".staticTexts[\"登录失败日志收集\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["日志采录设置"]/*[[".buttons[\"日志采录设置\"].staticTexts[\"日志采录设置\"]",".staticTexts[\"日志采录设置\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["只看重要的(级别大于 normal)"]/*[[".buttons[\"只看重要的(级别大于 normal)\"].staticTexts[\"只看重要的(级别大于 normal)\"]",".staticTexts[\"只看重要的(级别大于 normal)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["日志上传"]/*[[".buttons[\"日志上传\"].staticTexts[\"日志上传\"]",".staticTexts[\"日志上传\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
