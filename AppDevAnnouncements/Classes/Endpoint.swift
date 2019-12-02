//
//  Endpoint.swift
//  AppDevAnnouncements
//
//  Created by Gonzalo Gonzalez on 11/9/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import Foundation
import FutureNova

extension Endpoint {

    static func setupEndpointConfig(_ scheme: String, _ host: String, _ commonPath: String) {
        Endpoint.config.scheme = scheme
        Endpoint.config.host = host
        Endpoint.config.commonPath = commonPath
    }

    static func getAnnouncement(_ path: String) -> Endpoint {
        return Endpoint(path: path)
    }

}
