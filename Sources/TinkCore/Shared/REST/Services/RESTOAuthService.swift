import Foundation

final class RESTOAuthService: OAuthService {
    private let client: RESTClient

    init(client: RESTClient) {
        self.client = client
    }

    @discardableResult
    func createAnonymous(market: Market?, locale: Locale, origin: String?, completion: @escaping (Result<AccessToken, Error>) -> Void) -> RetryCancellable? {
        var localeIdentifier = locale.identifier
        if let languageCode = locale.languageCode, languageCode == "nb" || languageCode == "nn" {
            localeIdentifier = "no_NO"
        }

        let body = RESTAnonymousUserRequest(market: market?.code ?? "", origin: origin, locale: localeIdentifier)

        let request = RESTResourceRequest<RESTAnonymousUserResponse>(path: "/api/v1/user/anonymous", method: .post, body: body, contentType: .json) { result in

            completion(result.map { AccessToken($0.access_token) })
        }

        return client.performRequest(request)
    }

    @discardableResult
    func authenticate(clientID: String, code: AuthorizationCode, completion: @escaping (Result<AccessToken, Error>) -> Void) -> RetryCancellable? {
        let body = [
            "clientId": clientID,
            "code": code.rawValue
        ]
        let request = RESTResourceRequest<RESTAuthenticateResponse>(path: "/link/v1/authentication/token", method: .post, body: body, contentType: .json) { result in
            completion(result.map(\.accessToken).map(AccessToken.init(_:)))
        }

        return client.performRequest(request)
    }
}
