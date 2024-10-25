import Foundation

final class RESTCategoryService: CategoryService {
    private let client: RESTClient

    init(client: RESTClient) {
        self.client = client
    }

    @discardableResult
    func categories(
        completion: @escaping (Result<[Category], Error>) -> Void
    ) -> Cancellable? {
        let request = RESTResourceRequest<[RESTCategory]>(path: "/api/v1/categories", method: .get, contentType: .json) { result in
            completion(result.map { $0.map(Category.init) })
        }
        // FIXME: urlComponents.queryItems = [URLQueryItem(name: "locale", value: locale?.identifier)]
        return client.performRequest(request)
    }
}
