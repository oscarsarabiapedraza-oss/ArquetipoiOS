import XCTest
@testable import ArquetipoiOS


final class RegisterUseCaseTests: XCTestCase {
    func testRegisterSavesUser() throws {
        // Use in-memory Core Data stack
        let inMemStack = CoreDataStack(inMemory: true)
        let repo = CoreDataUserRepository(context: inMemStack.context)
        let uc = RegisterUserUseCaseImpl(repository: repo)
        let user = User(email: "a@b.com", password: "pass")
        try uc.execute(user: user)
        let fetched = try repo.fetch(byEmail: "a@b.com")
        XCTAssertNotNil(fetched)
        XCTAssertEqual(fetched?.email, "a@b.com")
    }
}
