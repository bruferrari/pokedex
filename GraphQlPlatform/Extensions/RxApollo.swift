import Foundation
import RxSwift
import Apollo

public enum RxApolloError: Error {
    /// One or more `GraphQLError`s were encountered.
    case graphQLErrors([GraphQLError])
}

extension ApolloClient: ReactiveCompatible { }

extension Reactive where Base: ApolloClient {
    public func fetch<Query: GraphQLQuery>(
            query: Query,
            cachePolicy: CachePolicy = .returnCacheDataElseFetch,
            queue: DispatchQueue = DispatchQueue.main) -> Single<Query.Data> {
        return Single.create { single in
            let cancellable = self.base.fetch(query: query,
                    cachePolicy: cachePolicy,
                    queue: queue) { (result: Apollo.GraphQLResult?, error: Error?) in
                guard error == nil, let result = result else {
                    single(.error(error!))
                    return
                }

                if let data = result.data {
                    single(.success(data))
                } else {
                    single(.error(RxApolloError.graphQLErrors(result.errors ?? [])))
                }
            }

            return Disposables.create {
                cancellable.cancel()
            }
        }
    }
}
