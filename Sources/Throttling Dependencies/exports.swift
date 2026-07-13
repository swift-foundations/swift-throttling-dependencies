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

// Re-exports both halves of the integration so `import Throttling_Dependencies`
// is a self-contained surface: the throttling vocabulary and the `\.date`
// dependency surface (which itself re-exports the dependency system) both
// appear in the vended API.

@_exported public import Clocks_Dependencies
@_exported public import Throttling
