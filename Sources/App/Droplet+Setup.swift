//
//  Droplet+Routes.swift
//  developer.sebastianboldt.com
//
//  Created by Sebastian Boldt on 24.05.17.
//
//

import Foundation
import Vapor

public extension Droplet {
    public func setupRoutes() throws {
        let routes = StaticRoutes(view)
        try collection(routes)
    }
}
