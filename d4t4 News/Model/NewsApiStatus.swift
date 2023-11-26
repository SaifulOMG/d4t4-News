//
//  NewsApiStatus.swift
//  d4t4 News
//
//  Created by Briteyellow on 26/11/2023.
//

import Foundation

enum NewsApiStatus {
    case ok
    case error
    var identifier: String {
        switch self {
        case .ok:
            return "ok"
        case .error:
            return "error"
        }
    }
}
