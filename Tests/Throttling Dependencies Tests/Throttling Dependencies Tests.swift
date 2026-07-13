// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-throttling-dependencies open source project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the swift-throttling-dependencies
// project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

import Dependencies_Test_Support
import Foundation
import Testing

@testable import Throttling_Dependencies

@Suite
struct `Throttling Dependencies Tests` {
    @Suite struct Unit {}
    @Suite struct Integration {}
}

extension `Throttling Dependencies Tests`.Unit {
    @Test
    func `checkLimit reads its timestamp from the date dependency`() async {
        let frozen = Date(timeIntervalSince1970: 1_000_000)
        let limiter = RateLimiter<String>(
            windows: [.minutes(1, maxAttempts: 1)]
        )

        await withDependencies {
            $0.date = .constant(frozen)
        } operation: {
            let first = await limiter.checkLimit("key")
            #expect(first.isAllowed)

            await limiter.recordAttempt("key", timestamp: frozen)

            let second = await limiter.checkLimit("key")
            #expect(!second.isAllowed)
        }
    }

    @Test
    func `advancing the injected date rolls the rate-limit window`() async {
        let frozen = Date(timeIntervalSince1970: 1_000_000)
        let limiter = RateLimiter<String>(
            windows: [.minutes(1, maxAttempts: 1)]
        )

        await limiter.recordAttempt("key", timestamp: frozen)

        await withDependencies {
            $0.date = .constant(frozen.addingTimeInterval(120))
        } operation: {
            let result = await limiter.checkLimit("key")
            #expect(result.isAllowed)
        }
    }
}

extension `Throttling Dependencies Tests`.Integration {
    @Test
    func `the live date dependency stamps a current timestamp`() async {
        let limiter = RateLimiter<String>(
            windows: [.minutes(1, maxAttempts: 5)]
        )

        let result = await limiter.checkLimit("key")
        #expect(result.isAllowed)
    }
}
