import Combine
import Testing
import XCTest

@testable import ArquetipoiOS

final class LoginUseCaseTests: XCTestCase {
    func testLoginSuccessFromMockAPI() throws {
        let api = MockLoginAPIClient(result: true)
        let uc = LoginUseCaseImpl(api: api)
        let exp = expectation(description: "login")
        var received: Bool?
        let cancellable = uc.execute(email: "x", password: "y")
            .sink { completion in
                if case .failure(let err) = completion {
                    XCTFail("unexpected error: \(err)")
                }
            } receiveValue: { success in
                received = success
                exp.fulfill()
            }
        waitForExpectations(timeout: 1.0)
        cancellable.cancel()
        XCTAssertEqual(received, true)
    }
}

// Mock API client for tests
class MockLoginAPIClient: LoginAPIClient {
    let result: Bool
    init(result: Bool) { self.result = result }
    func login(email: String, password: String) -> AnyPublisher<Bool, Error> {
        return Just(result)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
