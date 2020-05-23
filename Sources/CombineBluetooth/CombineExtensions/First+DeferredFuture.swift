import Combine

extension Publishers.First {
    public func asDeferredFuture() -> Deferred<Future<Output, Failure>> {
        Deferred {
            Future { callback in
                _ = self.sink(
                    receiveCompletion: { completion in
                        guard case let .failure(error) = completion else { return }
                        callback(.failure(error))
                    },
                    receiveValue: { value in
                        callback(.success(value))
                    }
                )
            }
        }
    }
}
