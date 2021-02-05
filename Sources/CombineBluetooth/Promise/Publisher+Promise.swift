//#if canImport(Combine)
//import Combine
//
//@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//    /// A Promise is a Publisher that lives in between First and Deferred.
//    /// It will listen to one and only one event, and finish successfully, or finish with error without any successful output.
//    /// It will hang until an event arrives from this upstream.
//    /// Calling it from `promise` property on the instance, means that this publisher was already created and can't be deferred
//    /// anymore. If you want to profit from lazy evaluation of Promise it's recommended to use the `Promise.init(Publisher)`,
//    /// that autoclosures the publisher and makes it lazy until the downstream sends demand (`.demand > .none`).
//    /// That way, you can safely add `Future` as upstream, for example, and be sure that its side-effect won't be started. The
//    /// behaviour, then, will be similar to `Promise<Output, Failure>>`, however with some extra features such as better
//    /// zips, and a run function to easily start the effect. The cancellation is possible and will be forwarded to the upstream
//    /// if the effect had already started.
//    public var promise: Promise<Output, Failure> {
//        Promise(self)
//    }
//}
//#endif
