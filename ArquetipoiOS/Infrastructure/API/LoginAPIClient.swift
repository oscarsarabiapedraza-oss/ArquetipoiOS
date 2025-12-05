import Foundation
import Combine

public struct LoginRequest: Codable {
    public let email: String
    public let password: String
}

public struct LoginResponse: Codable {
    public let success: Bool
}

public protocol LoginAPIClient {
    func login(email: String, password: String) -> AnyPublisher<Bool, Error>
}

public class URLSessionLoginAPIClient: LoginAPIClient {
    private let baseURL: URL

    public init(baseURL: URL = Config.baseURL) {
        self.baseURL = baseURL
    }

    public func login(email: String, password: String) -> AnyPublisher<Bool, Error> {
        let url = baseURL.appendingPathComponent("login")
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = LoginRequest(email: email, password: password)
        do {
            req.httpBody = try JSONEncoder().encode(body)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: req)
            .tryMap { data, resp in
                let http = resp as? HTTPURLResponse
                guard http?.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                let dec = try JSONDecoder().decode(LoginResponse.self, from: data)
                return dec.success
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
