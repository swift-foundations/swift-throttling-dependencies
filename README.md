# swift-throttling-dependencies

![Development Status](https://img.shields.io/badge/status-active--development-orange.svg)

Rate-limiter, pacer, and throttled-client entry points timestamped from the
[swift-dependencies](https://github.com/swift-foundations/swift-dependencies) `\.date` value.

> The throttling × dependencies integration package: call
> [swift-throttling](https://github.com/swift-foundations/swift-throttling)'s
> machinery without passing timestamps — the current instant is read from the
> `\.date` dependency, so tests control time by overriding one value.

## Overview

`import Throttling_Dependencies` adds timestamp-free entry points to the
swift-throttling surface:

| Base API | This package |
|----------|--------------|
| `RateLimiter.checkLimit(_:timestamp:)` | `RateLimiter.checkLimit(_:)` — timestamp from `\.date` |
| `RequestPacer.scheduleRequest(_:timestamp:)` | `RequestPacer.scheduleRequest(_:)` |
| `ThrottledClient.acquire(_:timestamp:)` | `ThrottledClient.acquire(_:)` |

The `\.date` key itself lives in
[swift-clocks-dependencies](https://github.com/swift-foundations/swift-clocks-dependencies)
and is re-exported here.

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-foundations/swift-throttling-dependencies.git", branch: "main")
]
```

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "Throttling Dependencies", package: "swift-throttling-dependencies")
    ]
)
```

## Quick Start

```swift
import Throttling_Dependencies

let limiter = RateLimiter<String>(
    windows: [.minutes(1, maxAttempts: 5)]
)

let result = await limiter.checkLimit("client-key")
guard result.isAllowed else { ... }
```

Override time in tests:

```swift
withDependencies {
    $0.date = .constant(Date(timeIntervalSince1970: 0))
} operation: {
    // checkLimit resolves its timestamp to the fixed instant
}
```

## License

Licensed under the [Apache License, Version 2.0](LICENSE.md).
