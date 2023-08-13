//
//  SignupWebServiceTests.swift
//  PhotoAppTests
//
//  Created by Brian Ortiz on 2023-08-07.
//  Copyright © 2023 Sergey Kargopolov. All rights reserved.
//

import XCTest
@testable import PhotoApp

final class SignupWebServiceTests: XCTestCase {

    var sut: SignupWebService!
    var requestModel: SignupRequestModel!
    
    override func setUp() {
        
        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockUrlProtocol.self]
        
        let urlSession = URLSession(configuration: config)
        
        sut = SignupWebService(urlString: SignupConstants.signupUrlString, urlSession: urlSession)
        
        requestModel = SignupRequestModel(firstName: "Brian", lastName: "Ortiz", email: "mateo972000@gmail.com", password: "12312321")
    }

    override func tearDown() {
        sut = nil
        requestModel = nil
        MockUrlProtocol.stubResponseData = nil
        MockUrlProtocol.error = nil
    }

    func testSignUpWebServiceSuccessResponse() {
        
        // Arrange
       
        let jsonString = "{\"status\": \"oks\"}"
        MockUrlProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = expectation(description: "Register user")
        
        //Act
        sut.signUpWithForm(requestModel) { response, error in
            
            //Assert
            XCTAssertEqual(response?.status, "oks")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testSignupResponseError() {
        // Arrange

        let jsonString = "{\"error\": true}"
        MockUrlProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = expectation(description: "Signup response diferent json structure")
        
        //Act
        sut.signUpWithForm(requestModel) { response, error in
            
            //Assert
            XCTAssertNil(response)
            XCTAssertEqual(error, .responseModelParsingError)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testInvalidUrlProvided() {
        //Arrange

        sut = SignupWebService(urlString: "")
        let expectation = expectation(description: "SignupWebService malformed URL")
        
        //Act
        sut.signUpWithForm(requestModel) { response, error in
            
            //Assert
            XCTAssertNil(response)
            XCTAssertEqual(error, .invalidUrl)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
    }
    
    func testSignupServiceFailedUrlRequest() {
        
        //Arrange
        let expectation = expectation(description: "Failed request expectation")
        
        let errorDesc = "Error localized description"
        MockUrlProtocol.error = SignupError.failedRequest(description: errorDesc)
        
        //Act
        sut.signUpWithForm(requestModel) { response, error in
    
            //Assert
            XCTAssertNil(response)
            
            XCTAssertEqual(error, .failedRequest(description: errorDesc))
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }

}
