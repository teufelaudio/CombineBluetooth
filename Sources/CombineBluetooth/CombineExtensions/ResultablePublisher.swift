import Combine

public protocol ResultablePublisher: Publisher {
    static func success(_ value: Output) -> Self
    static func failure(_ error: Failure) -> Self
}

extension ResultablePublisher {
    public func analysis(onSuccess: @escaping (Output) -> Void, onFailure: @escaping (Failure) -> Void) -> AnyCancellable {
        self.sink(
            receiveCompletion: {
                guard case let .failure(error) = $0 else { return }
                onFailure(error)
            },
            receiveValue: { value in
                onSuccess(value)
            }
        )
    }
}

extension Result.Publisher: ResultablePublisher {
    public static func success(_ value: Success) -> Result<Success, Failure>.Publisher {
        .init(value)
    }

    public static func failure(_ error: Failure) -> Result<Success, Failure>.Publisher {
        .init(error)
    }
}

extension Deferred: ResultablePublisher where DeferredPublisher: ResultablePublisher {
    public static func success(_ value: DeferredPublisher.Output) -> Deferred<DeferredPublisher> {
        .init(createPublisher: { .success(value) })
    }

    public static func failure(_ error: DeferredPublisher.Failure) -> Deferred<DeferredPublisher> {
        .init(createPublisher: { .failure(error) })
    }
}

extension Future: ResultablePublisher {
    public static func success(_ value: Output) -> Future<Output, Failure> {
        Future { completion in completion(.success(value)) }
    }

    public static func failure(_ error: Failure) -> Future<Output, Failure> {
        Future { completion in completion(.failure(error)) }
    }
}

extension Just: ResultablePublisher {
    public static func success(_ value: Output) -> Just<Output> {
        Just(value)
    }

    public static func failure(_ error: Never) -> Just<Output> {
    }
}

extension Fail: ResultablePublisher where Output == Never {
    public static func success(_ value: Output) -> Fail<Output, Failure> {

    }

    public static func failure(_ error: Failure) -> Fail<Output, Failure> {
        Fail(error: error)
    }
}

extension Publishers.First: ResultablePublisher where Upstream: ResultablePublisher {
    public static func success(_ value: Upstream.Output) -> Publishers.First<Upstream> {
        Publishers.First<Upstream>(upstream: .success(value))
    }

    public static func failure(_ error: Upstream.Failure) -> Publishers.First<Upstream> {
        Publishers.First<Upstream>(upstream: .failure(error))
    }
}
