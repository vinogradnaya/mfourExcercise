//
//  GalleryManagerTests.swift
//  mfourExcerciseTests
//
//  Created by Omelette on 7/22/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import XCTest

@testable import mfourExcercise
@testable import Alamofire

final class ObjectMock: NSObject, ResponseObjectSerializable {
    required init?(representation: Any) {}
}

extension ObjectMock: ResponseCollectionSerializable {
    static func collection(representation: Any) -> [ObjectMock] {
        return [ObjectMock(representation: "")!]
    }
}

class RequestMock: RequestProtocol {
    func cancelRequest() {}
}

class NetworkServiceMock: NetworkServiceProtocol {
    var error: Error?
    var objectResult: ObjectMock?
    var collectionResult: [ObjectMock]?

    func request<T>(_ endpoint: RestAPI, completionHandler: @escaping (Result<T>) -> Void) -> RequestProtocol where T : ResponseObjectSerializable {
        if let error = error {
            completionHandler(.failure(error))
        } else if let objectResult = objectResult {
            completionHandler(.success(objectResult as! T))
        }
        return RequestMock()
    }

    func request<T>(_ endpoint: RestAPI, completionHandler: @escaping (Result<[T]>) -> Void) -> RequestProtocol where T : ResponseCollectionSerializable {
        if let error = error {
            completionHandler(.failure(error))
        } else if let collectionResult = collectionResult {
            completionHandler(.success(collectionResult as! [T]))
        }
        return RequestMock()
    }
}

class GalleryManagerTests: XCTestCase {
    var galleryManager: GalleryManager!
    var networkService: NetworkServiceMock!

    override func setUp() {
        super.setUp()
        networkService = NetworkServiceMock()
        galleryManager = GalleryManager(networkService: networkService)
    }

    override func tearDown() {
        galleryManager = nil
        networkService = nil
        super.tearDown()
    }

    func testGalleryManagerSearchIsSuccessIfBackendRepliesWithObjects() {
        let collection = [ObjectMock(representation: "")]
        networkService.collectionResult = (collection as! [ObjectMock])
        networkService.error = nil

        let expectation = self.expectation(description: "successfull search expectation")
        galleryManager.search(query: "") { result in
            switch result {
            case .failure(_):
                XCTFail("unexpected result")
            case .success(_):
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGalleryManagerSearchFailsIfBackendReplyWithError() {
        let errorTemp = NSError(domain:"", code:123, userInfo:nil)
        let error = BackendError.network(error: errorTemp)
        networkService.error = error

        let expectation = self.expectation(description: "successfull error propagation")
        galleryManager.search(query: "") { result in
            switch result {
            case .failure(_):
                expectation.fulfill()
            case .success(_):
                XCTFail("unexpected result")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGalleryManagerSearchContainsCorrectNumberOfResults() {
        let collection = [ObjectMock(representation: "")]
        networkService.collectionResult = (collection as! [ObjectMock])
        networkService.error = nil

        let expectation = self.expectation(description: "successfull search expectation")
        galleryManager.search(query: "") { result in
            switch result {
            case .failure(_):
                XCTFail("unexpected result")
            case .success(let objects):
                guard objects.count == 1 else {
                    XCTFail("incorrect number of objects")
                    return
                }
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGalleryManagerFetchCommentsIsSuccessIfBackendRepliesWithObjects() {
        let collection = [ObjectMock(representation: "")]
        networkService.collectionResult = (collection as! [ObjectMock])
        networkService.error = nil

        let expectation = self.expectation(description: "successfull search expectation")
        galleryManager.fetchComments(id: "123", completionHandler: { result in
            switch result {
            case .failure(_):
                XCTFail("unexpected result")
            case .success(_):
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGalleryManagerFetchCommentsFailsIfBackendReplyWithError() {
        let errorTemp = NSError(domain:"", code:123, userInfo:nil)
        let error = BackendError.network(error: errorTemp)
        networkService.error = error

        let expectation = self.expectation(description: "successfull error propagation")
        galleryManager.fetchComments(id: "123", completionHandler: { result in
            switch result {
            case .failure(_):
                expectation.fulfill()
            case .success(_):
                XCTFail("unexpected result")
            }
        })

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGalleryManagerFetchCommentsContainsCorrectNumberOfResults() {
        let collection = [ObjectMock(representation: "")]
        networkService.collectionResult = (collection as! [ObjectMock])
        networkService.error = nil

        let expectation = self.expectation(description: "successfull search expectation")
        galleryManager.fetchComments(id: "123", completionHandler: { result in
            switch result {
            case .failure(_):
                XCTFail("unexpected result")
            case .success(let objects):
                guard objects.count == 1 else {
                    XCTFail("incorrect number of objects")
                    return
                }
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
}


