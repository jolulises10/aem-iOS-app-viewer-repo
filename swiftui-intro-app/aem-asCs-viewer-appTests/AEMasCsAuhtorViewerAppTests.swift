//
//  swiftui_intro_appTests.swift
//  swiftui-intro-appTests
//
//  Created by Jorge Rodriguez on 07/06/2022.
//

import XCTest
import Combine

@testable import AEM_asCs_Author_Viewer

@MainActor class AEM_asCs_Author_ViewerTests: XCTestCase {
    
    var loginViewModel: AemLogin!
    var stringURL: String?
    var url: URL?

    @MainActor override func setUpWithError() throws {
        loginViewModel = AemLogin()
        stringURL = "http://localhost:4504/j_security_check"
        url = URL(string: stringURL!)
        URLProtocol.registerClass(MockURLProtocol.self)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAemLoginSuccesful() throws {
        //given
        MockURLProtocol.data = [url: Data("{\"user\":admin}".utf8)]
        MockURLProtocol.httpResponse = [url: HTTPURLResponse(url: url!, statusCode: 200, httpVersion: "", headerFields: nil)!]
        
        //when
        loginViewModel.callAuthPostAPI(urlString: stringURL!)
        waitUntil(loginViewModel.$isLoggedin, equals: true)
        
        //then
        XCTAssertTrue(loginViewModel.isLoggedin)
    }
    
    func testAemLoginFailed() throws {
        //given
        MockURLProtocol.data = [url: Data("".utf8)]
        MockURLProtocol.httpResponse = [url: HTTPURLResponse(url: url!, statusCode: 401, httpVersion: "", headerFields: nil)!]
        
        //when
        loginViewModel.callAuthPostAPI(urlString: stringURL!)
        waitUntil(loginViewModel.$isLoggedin, equals: false)
        
        //then
        XCTAssertFalse(loginViewModel.isLoggedin)
    }
    
    func waitUntil<T: Equatable>(_ propertyPublisher: Published<T>.Publisher,
                                 equals expectedValue: T,
                                 timeout: TimeInterval = 10,
                                 file: StaticString = #file,
                                 line: UInt = #line) {
        let expectation = expectation(
            description: "Awaiting value \(expectedValue)"
        )

        var cancellable: AnyCancellable?

        cancellable = propertyPublisher
            .dropFirst()
            .first(where: { $0 == expectedValue })
            .sink { value in
                XCTAssertEqual(value, expectedValue, file: file, line: line)
                cancellable?.cancel()
                expectation.fulfill()
            }

        waitForExpectations(timeout: timeout, handler: nil)
    }

}
