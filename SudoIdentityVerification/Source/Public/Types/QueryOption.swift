//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Options for controlling the behaviour of query APIs.
///
/// - cacheOnly: returns query result from the local cache only.
/// - remoteOnly: performs the query in the backend and ignores any cached entries.
public enum QueryOption {
    case cacheOnly
    case remoteOnly
}
