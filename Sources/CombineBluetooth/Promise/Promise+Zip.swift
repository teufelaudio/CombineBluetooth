//
//  Promise+Zip.swift
//  FoundationExtensions
//
//  Created by Luiz Barbosa on 29.05.20.
//  Copyright © 2020 Lautsprecher Teufel GmbH. All rights reserved.
//

#if canImport(Combine)
import Combine

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Promise {
    /// Zips two promises in a promise. The upstream results will be merged with the provided map function.
    /// This is useful for calling async operations in parallel, creating a race that waits for the slowest
    /// one, so all of them will complete, be mapped and then forwarded to the downstream.
    /// - Parameters:
    ///   - p1: first promise
    ///   - p2: second promise
    ///   - map: merging all the upstream outputs in the downstream output
    /// - Returns: a new promise that will complete when all upstreams gave their results and the were
    ///            mapped into the downstream output
    public static func zip<P1, P2>(
        _ p1: Promise<P1, Failure>,
        _ p2: Promise<P2, Failure>,
        map: @escaping (P1, P2) -> Output
    ) -> Promise<Output, Failure> {
        Promise(
            Publishers.Zip(p1, p2)
                .map(map)
        )
    }

    /// Zips three promises in a promise. The upstream results will be merged with the provided map function.
    /// This is useful for calling async operations in parallel, creating a race that waits for the slowest
    /// one, so all of them will complete, be mapped and then forwarded to the downstream.
    /// - Parameters:
    ///   - p1: first promise
    ///   - p2: second promise
    ///   - p3: third promise
    ///   - map: merging all the upstream outputs in the downstream output
    /// - Returns: a new promise that will complete when all upstreams gave their results and the were
    ///            mapped into the downstream output
    public static func zip<P1, P2, P3>(
        _ p1: Promise<P1, Failure>,
        _ p2: Promise<P2, Failure>,
        _ p3: Promise<P3, Failure>,
        map: @escaping (P1, P2, P3) -> Output
    ) -> Promise<Output, Failure> {
        Promise(
            Publishers.Zip3(p1, p2, p3)
                .map(map)
        )
    }

    /// Zips four promises in a promise. The upstream results will be merged with the provided map function.
    /// This is useful for calling async operations in parallel, creating a race that waits for the slowest
    /// one, so all of them will complete, be mapped and then forwarded to the downstream.
    /// - Parameters:
    ///   - p1: first promise
    ///   - p2: second promise
    ///   - p3: third promise
    ///   - p4: fourth promise
    ///   - map: merging all the upstream outputs in the downstream output
    /// - Returns: a new promise that will complete when all upstreams gave their results and the were
    ///            mapped into the downstream output
    public static func zip<P1, P2, P3, P4>(
        _ p1: Promise<P1, Failure>,
        _ p2: Promise<P2, Failure>,
        _ p3: Promise<P3, Failure>,
        _ p4: Promise<P4, Failure>,
        map: @escaping (P1, P2, P3, P4) -> Output
    ) -> Promise<Output, Failure> {
        Promise(
            Publishers.Zip4(p1, p2, p3, p4)
                .map(map)
        )
    }

    /// Zips five promises in a promise. The upstream results will be merged with the provided map function.
    /// This is useful for calling async operations in parallel, creating a race that waits for the slowest
    /// one, so all of them will complete, be mapped and then forwarded to the downstream.
    /// - Parameters:
    ///   - p1: first promise
    ///   - p2: second promise
    ///   - p3: third promise
    ///   - p4: fourth promise
    ///   - p5: fifth promise
    ///   - map: merging all the upstream outputs in the downstream output
    /// - Returns: a new promise that will complete when all upstreams gave their results and the were
    ///            mapped into the downstream output
    public static func zip<P1, P2, P3, P4, P5>(
        _ p1: Promise<P1, Failure>,
        _ p2: Promise<P2, Failure>,
        _ p3: Promise<P3, Failure>,
        _ p4: Promise<P4, Failure>,
        _ p5: Promise<P5, Failure>,
        map: @escaping (P1, P2, P3, P4, P5) -> Output
    ) -> Promise<Output, Failure> {
        Promise(
            Publishers.Zip(
                Publishers.Zip4(p1, p2, p3, p4),
                p5
            )
            .map { tuple -> Output in
                map(tuple.0.0, tuple.0.1, tuple.0.2, tuple.0.3, tuple.1)
            }
        )
    }

    /// Zips six promises in a promise. The upstream results will be merged with the provided map function.
    /// This is useful for calling async operations in parallel, creating a race that waits for the slowest
    /// one, so all of them will complete, be mapped and then forwarded to the downstream.
    /// - Parameters:
    ///   - p1: first promise
    ///   - p2: second promise
    ///   - p3: third promise
    ///   - p4: fourth promise
    ///   - p5: fifth promise
    ///   - p6: sixth promise
    ///   - map: merging all the upstream outputs in the downstream output
    /// - Returns: a new promise that will complete when all upstreams gave their results and the were
    ///            mapped into the downstream output
    public static func zip<P1, P2, P3, P4, P5, P6>(
        _ p1: Promise<P1, Failure>,
        _ p2: Promise<P2, Failure>,
        _ p3: Promise<P3, Failure>,
        _ p4: Promise<P4, Failure>,
        _ p5: Promise<P5, Failure>,
        _ p6: Promise<P6, Failure>,
        map: @escaping (P1, P2, P3, P4, P5, P6) -> Output
    ) -> Promise<Output, Failure> {
        Promise(
            Publishers.Zip(
                Publishers.Zip4(p1, p2, p3, p4),
                Publishers.Zip(p5, p6)
            )
            .map { tuple -> Output in
                map(tuple.0.0, tuple.0.1, tuple.0.2, tuple.0.3, tuple.1.0, tuple.1.1)
            }
        )
    }

    /// Zips seven promises in a promise. The upstream results will be merged with the provided map function.
    /// This is useful for calling async operations in parallel, creating a race that waits for the slowest
    /// one, so all of them will complete, be mapped and then forwarded to the downstream.
    /// - Parameters:
    ///   - p1: first promise
    ///   - p2: second promise
    ///   - p3: third promise
    ///   - p4: fourth promise
    ///   - p5: fifth promise
    ///   - p6: sixth promise
    ///   - p7: seventh promise
    ///   - map: merging all the upstream outputs in the downstream output
    /// - Returns: a new promise that will complete when all upstreams gave their results and the were
    ///            mapped into the downstream output
    public static func zip<P1, P2, P3, P4, P5, P6, P7>(
        _ p1: Promise<P1, Failure>,
        _ p2: Promise<P2, Failure>,
        _ p3: Promise<P3, Failure>,
        _ p4: Promise<P4, Failure>,
        _ p5: Promise<P5, Failure>,
        _ p6: Promise<P6, Failure>,
        _ p7: Promise<P7, Failure>,
        map: @escaping (P1, P2, P3, P4, P5, P6, P7) -> Output
    ) -> Promise<Output, Failure> {
        Promise(
            Publishers.Zip(
                Publishers.Zip4(p1, p2, p3, p4),
                Publishers.Zip3(p5, p6, p7)
            )
            .map { tuple -> Output in
                map(tuple.0.0, tuple.0.1, tuple.0.2, tuple.0.3, tuple.1.0, tuple.1.1, tuple.1.2)
            }
        )
    }

    /// Zips eight promises in a promise. The upstream results will be merged with the provided map function.
    /// This is useful for calling async operations in parallel, creating a race that waits for the slowest
    /// one, so all of them will complete, be mapped and then forwarded to the downstream.
    /// - Parameters:
    ///   - p1: first promise
    ///   - p2: second promise
    ///   - p3: third promise
    ///   - p4: fourth promise
    ///   - p5: fifth promise
    ///   - p6: sixth promise
    ///   - p7: seventh promise
    ///   - p8: eighth promise
    ///   - map: merging all the upstream outputs in the downstream output
    /// - Returns: a new promise that will complete when all upstreams gave their results and the were
    ///            mapped into the downstream output
    public static func zip<P1, P2, P3, P4, P5, P6, P7, P8>(
        _ p1: Promise<P1, Failure>,
        _ p2: Promise<P2, Failure>,
        _ p3: Promise<P3, Failure>,
        _ p4: Promise<P4, Failure>,
        _ p5: Promise<P5, Failure>,
        _ p6: Promise<P6, Failure>,
        _ p7: Promise<P7, Failure>,
        _ p8: Promise<P8, Failure>,
        map: @escaping (P1, P2, P3, P4, P5, P6, P7, P8) -> Output
    ) -> Promise<Output, Failure> {
        Promise(
            Publishers.Zip(
                Publishers.Zip4(p1, p2, p3, p4),
                Publishers.Zip4(p5, p6, p7, p8)
            )
            .map { tuple -> Output in
                map(tuple.0.0, tuple.0.1, tuple.0.2, tuple.0.3, tuple.1.0, tuple.1.1, tuple.1.2, tuple.1.3)
            }
        )
    }

    /// Zips nine promises in a promise. The upstream results will be merged with the provided map function.
    /// This is useful for calling async operations in parallel, creating a race that waits for the slowest
    /// one, so all of them will complete, be mapped and then forwarded to the downstream.
    /// - Parameters:
    ///   - p1: first promise
    ///   - p2: second promise
    ///   - p3: third promise
    ///   - p4: fourth promise
    ///   - p5: fifth promise
    ///   - p6: sixth promise
    ///   - p7: seventh promise
    ///   - p8: eighth promise
    ///   - p9: ninth promise
    ///   - map: merging all the upstream outputs in the downstream output
    /// - Returns: a new promise that will complete when all upstreams gave their results and the were
    ///            mapped into the downstream output
    public static func zip<P1, P2, P3, P4, P5, P6, P7, P8, P9>(
        _ p1: Promise<P1, Failure>,
        _ p2: Promise<P2, Failure>,
        _ p3: Promise<P3, Failure>,
        _ p4: Promise<P4, Failure>,
        _ p5: Promise<P5, Failure>,
        _ p6: Promise<P6, Failure>,
        _ p7: Promise<P7, Failure>,
        _ p8: Promise<P8, Failure>,
        _ p9: Promise<P9, Failure>,
        map: @escaping (P1, P2, P3, P4, P5, P6, P7, P8, P9) -> Output
    ) -> Promise<Output, Failure> {
        Promise(
            Publishers.Zip3(
                Publishers.Zip4(p1, p2, p3, p4),
                Publishers.Zip4(p5, p6, p7, p8),
                p9
            )
            .map { tuple -> Output in
                map(tuple.0.0, tuple.0.1, tuple.0.2, tuple.0.3, tuple.1.0, tuple.1.1, tuple.1.2, tuple.1.3, tuple.2)
            }
        )
    }

    /// Zips ten promises in a promise. The upstream results will be merged with the provided map function.
    /// This is useful for calling async operations in parallel, creating a race that waits for the slowest
    /// one, so all of them will complete, be mapped and then forwarded to the downstream.
    /// - Parameters:
    ///   - p1: first promise
    ///   - p2: second promise
    ///   - p3: third promise
    ///   - p4: fourth promise
    ///   - p5: fifth promise
    ///   - p6: sixth promise
    ///   - p7: seventh promise
    ///   - p8: eighth promise
    ///   - p9: ninth promise
    ///   - p10: tenth promise
    ///   - map: merging all the upstream outputs in the downstream output
    /// - Returns: a new promise that will complete when all upstreams gave their results and the were
    ///            mapped into the downstream output
    public static func zip<P1, P2, P3, P4, P5, P6, P7, P8, P9, P10>(
        _ p1: Promise<P1, Failure>,
        _ p2: Promise<P2, Failure>,
        _ p3: Promise<P3, Failure>,
        _ p4: Promise<P4, Failure>,
        _ p5: Promise<P5, Failure>,
        _ p6: Promise<P6, Failure>,
        _ p7: Promise<P7, Failure>,
        _ p8: Promise<P8, Failure>,
        _ p9: Promise<P9, Failure>,
        _ p10: Promise<P10, Failure>,
        map: @escaping (P1, P2, P3, P4, P5, P6, P7, P8, P9, P10) -> Output
    ) -> Promise<Output, Failure> {
        Promise(
            Publishers.Zip3(
                Publishers.Zip4(p1, p2, p3, p4),
                Publishers.Zip4(p5, p6, p7, p8),
                Publishers.Zip(p9, p10)
            )
            .map { tuple -> Output in
                map(tuple.0.0, tuple.0.1, tuple.0.2, tuple.0.3, tuple.1.0, tuple.1.1, tuple.1.2, tuple.1.3, tuple.2.0, tuple.2.1)
            }
        )
    }

    /// Zips eleven promises in a promise. The upstream results will be merged with the provided map function.
    /// This is useful for calling async operations in parallel, creating a race that waits for the slowest
    /// one, so all of them will complete, be mapped and then forwarded to the downstream.
    /// - Parameters:
    ///   - p1: first promise
    ///   - p2: second promise
    ///   - p3: third promise
    ///   - p4: fourth promise
    ///   - p5: fifth promise
    ///   - p6: sixth promise
    ///   - p7: seventh promise
    ///   - p8: eighth promise
    ///   - p9: ninth promise
    ///   - p10: tenth promise
    ///   - p11: eleventh promise
    ///   - map: merging all the upstream outputs in the downstream output
    /// - Returns: a new promise that will complete when all upstreams gave their results and the were
    ///            mapped into the downstream output
    public static func zip<P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11>(
        _ p1: Promise<P1, Failure>,
        _ p2: Promise<P2, Failure>,
        _ p3: Promise<P3, Failure>,
        _ p4: Promise<P4, Failure>,
        _ p5: Promise<P5, Failure>,
        _ p6: Promise<P6, Failure>,
        _ p7: Promise<P7, Failure>,
        _ p8: Promise<P8, Failure>,
        _ p9: Promise<P9, Failure>,
        _ p10: Promise<P10, Failure>,
        _ p11: Promise<P11, Failure>,
        map: @escaping (P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11) -> Output
    ) -> Promise<Output, Failure> {
        Promise(
            Publishers.Zip3(
                Publishers.Zip4(p1, p2, p3, p4),
                Publishers.Zip4(p5, p6, p7, p8),
                Publishers.Zip3(p9, p10, p11)
            )
            .map { tuple -> Output in
                map(tuple.0.0, tuple.0.1, tuple.0.2, tuple.0.3, tuple.1.0, tuple.1.1, tuple.1.2, tuple.1.3, tuple.2.0, tuple.2.1, tuple.2.2)
            }
        )
    }

    /// Zips twelve promises in a promise. The upstream results will be merged with the provided map function.
    /// This is useful for calling async operations in parallel, creating a race that waits for the slowest
    /// one, so all of them will complete, be mapped and then forwarded to the downstream.
    /// - Parameters:
    ///   - p1: first promise
    ///   - p2: second promise
    ///   - p3: third promise
    ///   - p4: fourth promise
    ///   - p5: fifth promise
    ///   - p6: sixth promise
    ///   - p7: seventh promise
    ///   - p8: eighth promise
    ///   - p9: ninth promise
    ///   - p10: tenth promise
    ///   - p11: eleventh promise
    ///   - p12: twelfth promise
    ///   - map: merging all the upstream outputs in the downstream output
    /// - Returns: a new promise that will complete when all upstreams gave their results and the were
    ///            mapped into the downstream output
    public static func zip<P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12>(
        _ p1: Promise<P1, Failure>,
        _ p2: Promise<P2, Failure>,
        _ p3: Promise<P3, Failure>,
        _ p4: Promise<P4, Failure>,
        _ p5: Promise<P5, Failure>,
        _ p6: Promise<P6, Failure>,
        _ p7: Promise<P7, Failure>,
        _ p8: Promise<P8, Failure>,
        _ p9: Promise<P9, Failure>,
        _ p10: Promise<P10, Failure>,
        _ p11: Promise<P11, Failure>,
        _ p12: Promise<P12, Failure>,
        map: @escaping (P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12) -> Output
    ) -> Promise<Output, Failure> {
        Promise(
            Publishers.Zip3(
                Publishers.Zip4(p1, p2, p3, p4),
                Publishers.Zip4(p5, p6, p7, p8),
                Publishers.Zip4(p9, p10, p11, p12)
            )
            .map { tuple -> Output in
                map(tuple.0.0, tuple.0.1, tuple.0.2, tuple.0.3, tuple.1.0, tuple.1.1, tuple.1.2, tuple.1.3, tuple.2.0, tuple.2.1, tuple.2.2, tuple.2.3)
            }
        )
    }
}
#endif
