//
//  Walmart_ServiceTests.swift
//  Walmart-WaIETests
//
//  Created by kandavel on 04/03/23.
//

import XCTest
@testable import Walmart_WaIE

final class Walmart_ServiceTests: XCTestCase {
    
    private var sut: DailyPicService!
    private var mockSession: NetworkSessionMock!
    private let date = ""
    
    private var pictureTitle : String?
    private var explanantionTitle : String?
    private var imageUrl : String?

    override func setUpWithError() throws {
        mockSession = NetworkSessionMock()
        sut = DailyPicService()
    }

    override func tearDownWithError() throws {
        sut = nil
        mockSession = nil
    }
    
    func test_getchAPODreturnsValidData() {
        // GIVEN
        var result: Result<Picture, NetworkError>?
        // WHEN
        let endPoint  = DailyPicServiceEndPoint.getDailyPicture(name: "")
        sut.fetchDailyPictures(endPoint) {result = $0}
        // THEN
        switch result {
        case .success(let picture):
            pictureTitle =  picture.title
            imageUrl =  picture.url
            explanantionTitle =  picture.explanation
            break
        case .failure(let _):
            break
        case .none:
            break
        }
        XCTAssertTrue(!(pictureTitle?.isEmpty ?? false), "Your value is false, but you expected it to be true")
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

private class NetworkSessionMock: MoviesServiceProtocol {
    
    var result : Picture?
    var error : NetworkError?

    func fetchDailyPictures(_ endPoint : Endpoint,completionHandler: @escaping (PictureResult) -> ()) {
        completionHandler(.success(result ?? Picture()))
    }
}
