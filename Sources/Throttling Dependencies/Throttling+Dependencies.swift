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

public import Clocks_Dependencies
public import Dependencies
public import Foundation
public import Throttling

// MARK: - RateLimiter

extension RateLimiter {
    /// Checks whether a request should be allowed, timestamped from the
    /// `\.date` dependency.
    public func checkLimit(
        _ key: Key
    ) async -> RateLimitResult {
        @Dependency(\.date) var date
        let timestamp: Date = date()

        return await self.checkLimit(key, timestamp: timestamp)
    }
}

// MARK: - RequestPacer

extension RequestPacer {
    /// Schedules a request, timestamped from the `\.date` dependency.
    public func scheduleRequest(
        _ key: Key
    ) async -> ScheduleResult {
        @Dependency(\.date) var date
        let timestamp: Date = date()

        return await self.scheduleRequest(key, timestamp: timestamp)
    }
}

// MARK: - ThrottledClient

extension ThrottledClient {
    /// Acquires a slot, timestamped from the `\.date` dependency.
    public func acquire(
        _ key: Key
    ) async -> AcquisitionResult {
        @Dependency(\.date) var date
        let timestamp: Date = date()

        return await self.acquire(key, timestamp: timestamp)
    }
}
