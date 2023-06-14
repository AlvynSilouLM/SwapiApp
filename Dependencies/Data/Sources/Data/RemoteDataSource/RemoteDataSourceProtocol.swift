//
//  RemoteDataSourceProtocol.swift
//

import Foundation

public protocol RemoteDataSourceProtocol {
    var httpClient: HTTPClient { get }
    var router: Router { get }
}
