import Foundation

public protocol AuthenticationService {
    func clientDescription(clientID: String, scopes: [Scope], redirectURI: URL, completion: @escaping (Result<ClientDescription, Error>) -> Void) -> RetryCancellable?
    func authorize(clientID: String, redirectURI: URL, scopes: [Scope], completion: @escaping (Result<AuthorizationCode, Error>) -> Void) -> RetryCancellable?
}
