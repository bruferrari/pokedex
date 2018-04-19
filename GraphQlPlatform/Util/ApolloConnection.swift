import Foundation
import Apollo

final class ApolloConnection {
    let client: ApolloClient

    init(apiUrl: URL, configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        let networkTransport = HTTPNetworkTransport(url: apiUrl, configuration: configuration)
        self.client = ApolloClient(networkTransport: networkTransport)
    }
}
