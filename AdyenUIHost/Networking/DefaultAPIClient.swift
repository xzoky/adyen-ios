//
// Copyright (c) 2020 Adyen N.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

import Adyen
import Foundation

internal final class DefaultAPIClient: AnyRetryAPIClient {
    
    internal let apiClient: RetryAPIClient = RetryAPIClient(apiClient: APIClient(environment: Configuration.environment),
                                                            scheduler: SimpleScheduler(maximumCount: 2))
    
    internal func perform<R>(_ request: R, completionHandler: @escaping (Result<R.ResponseType, Error>) -> Void) where R: Request {
        apiClient.perform(request, completionHandler: completionHandler)
    }
    
    internal func perform<R>(_ request: R, shouldRetry: ((Result<R.ResponseType, Error>) -> Bool)?, completionHandler: @escaping (Result<R.ResponseType, Error>) -> Void) where R: Request {
        apiClient.perform(request, shouldRetry: {
            if case .failure = $0 {
                return true
            }
            return false
        }, completionHandler: completionHandler)
    }
}
