#if canImport(Combine)
import Combine
public typealias Promise<Output, InnerError: Error> = Deferred<Future<Output, PromiseError<InnerError>>>
func absurd<T>(_ never: Never) -> T { }

extension Promise {
    public static func create<InnerError: Error>(error: InnerError) -> Promise<Output, InnerError> {
        .init {
            .init { completion in
                completion(.failure(PromiseError.completedWithError(error)))
            }
        }
    }
}

public enum PromiseError<Failure: Error>: Error {
    case completedWithoutValue
    case completedWithError(Failure)
}

extension Promise {
    public static func first<P: Publisher, InnerError>(of upstream: P) -> Promise<Output, InnerError>
    where P.Output == Self.Output, P.Failure == InnerError {
        .init {
            .init { completion in
                upstream
                    .first()
                    .subscribe(
                        AnySubscriber(
                            receiveSubscription: nil,
                            receiveValue: { value in
                                completion(.success(value))
                                return .none
                            },
                            receiveCompletion: { result in
                                switch result {
                                case let .failure(error):
                                    completion(.failure(.completedWithError(error)))
                                case .finished:
                                    completion(.failure(.completedWithoutValue))
                                }
                            }
                        )
                    )
            }
        }
    }
}
#endif

//#if canImport(Combine)
//import Combine
//import class Foundation.NSRecursiveLock
//
//func absurd<T>(_ never: Never) -> T { }
//
//@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
///// A Promise is a Publisher that lives in between First and Deferred.
///// It will listen to one and only one event, and finish successfully, or finish with error without any successful output.
///// It will hang until an event arrives from upstream. If the upstream is eager, it will be deferred, that means it won't
///// be created (therefore, no side-effect possible) until the downstream sends demand (`.demand > .none`). This, of course,
///// if it was not created yet before passed to this initializer.
///// That way, you can safely add `Future` as upstream, for example, and be sure that its side-effect won't be started. The
///// behaviour, then, will be similar to `Deferred<Future<Output, Failure>>`, however with some extra features such as better
///// zips, and a run function to easily start the effect. The cancellation is possible and will be forwarded to the upstream
///// if the effect had already started.
///// Promises can be created from any Publisher, but only the first element will be relevant. It can also be created from
///// hardcoded success or failure values, or from a Result. In any of these cases, the evaluation of the value will be deferred
///// so be sure to use values with copy semantic (value type).
//public struct Promise<Success, Failure: Error>: Publisher {
//    /// The kind of values published by this publisher.
//    public typealias Output = Success
//
//    private let upstream: () -> AnyPublisher<Success, Failure>
//
//    /// A promise from an upstream publisher. Because this is an autoclosure parameter, the upstream will become a factory
//    /// and its creation will be deferred until there's some positive demand from the downstream.
//    /// - Parameter upstream: a closure that creates an upstream publisher. This is an autoclosure, so creation will be
//    ///                       deferred.
//    public init<P: Publisher>(_ upstream: @autoclosure @escaping () -> P) where P.Output == Success, P.Failure == Failure {
//        self.upstream = { upstream().eraseToAnyPublisher() }
//    }
//
//    /// A promise from a hardcoded successful value
//    /// - Parameter value: a hardcoded successful value. It's gonna be evaluated on demand from downstream
//    public init(value: Success) {
//        self.upstream = { Just(value).mapError(absurd).eraseToAnyPublisher() }
//    }
//
//    /// A promise from a hardcoded error
//    /// - Parameter error: a hardcoded error. It's gonna be evaluated on demand from downstream
//    public init(error: Failure) {
//        self.upstream = { Fail(error: error).map(absurd).eraseToAnyPublisher() }
//    }
//
//    /// A promise from a hardcoded result value
//    /// - Parameter value: a hardcoded result value. It's gonna be evaluated on demand from downstream
//    public init(result: Result<Output, Failure>) {
//        self.upstream = { result.publisher.eraseToAnyPublisher() }
//    }
//
//    /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//    ///
//    /// - SeeAlso: `subscribe(_:)`
//    /// - Parameters:
//    ///     - subscriber: The subscriber to attach to this `Publisher`.
//    ///                   once attached it can begin to receive values.
//    public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
//        subscriber.receive(subscription: Subscription.init(upstream: upstream, downstream: subscriber))
//    }
//}
//
//@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Promise {
//    class Subscription<Downstream: Subscriber>: Combine.Subscription where Output == Downstream.Input, Failure == Downstream.Failure {
//        private let lock = NSRecursiveLock()
//        private var hasStarted = false
//        private let upstream: () -> AnyPublisher<Success, Failure>
//        private let downstream: Downstream
//        private var cancellable: AnyCancellable?
//
//        public init(upstream: @escaping () -> AnyPublisher<Output, Failure>, downstream: Downstream) {
//            self.upstream = upstream
//            self.downstream = downstream
//        }
//
//        func request(_ demand: Subscribers.Demand) {
//            guard demand > .none else { return }
//
//            lock.lock()
//            let shouldRun = !hasStarted
//            hasStarted = true
//            lock.unlock()
//
//            guard shouldRun else { return }
//
//            cancellable = upstream()
//                .first()
//                .sink(
//                    receiveCompletion: { [weak self] completion in
//                        self?.downstream.receive(completion: completion)
//                    },
//                    receiveValue: { [weak self] value in
//                        _ = self?.downstream.receive(value)
//                        self?.downstream.receive(completion: .finished)
//                    }
//                )
//        }
//
//        func cancel() {
//            cancellable?.cancel()
//        }
//    }
//}
//
//@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Promise {
//    /// Similar to .sink, but with correct semantic for a single-value success or a failure. Creates demand for 1
//    /// value and completes after it, or on error.
//    /// - Parameters:
//    ///   - onSuccess: called when the promise is fulfilled successful with a value. Called only once and then
//    ///                you can consider this stream finished
//    ///   - onFailure: called when the promise finds error. Called only once completing the stream. It's never
//    ///                called if a success was already called
//    /// - Returns: the subscription that can be cancelled at any point.
//    public func run(onSuccess: @escaping (Output) -> Void, onFailure: @escaping (Failure) -> Void) -> AnyCancellable {
//        sink(
//            receiveCompletion: { completion in
//                if case let .failure(error) = completion {
//                    onFailure(error)
//                }
//            },
//            receiveValue: onSuccess
//        )
//    }
//}
//
//@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Promise where Failure == Never {
//    public func run(onSuccess: @escaping (Output) -> Void) -> AnyCancellable {
//        run(onSuccess: onSuccess, onFailure: { _ in })
//    }
//}
//
//@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Promise where Success == Void {
//    public func run(onFailure: @escaping (Failure) -> Void) -> AnyCancellable {
//        run(onSuccess: { _ in }, onFailure: onFailure)
//    }
//}
//
//@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Promise where Success == Void, Failure == Never {
//    public func run() -> AnyCancellable {
//        run(onSuccess: { _ in }, onFailure: { _ in })
//    }
//}
//#endif
