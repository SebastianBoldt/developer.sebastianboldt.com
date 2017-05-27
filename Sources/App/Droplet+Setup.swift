//
//  Droplet+Routes.swift
//  developer.sebastianboldt.com
//
//  Created by Sebastian Boldt on 24.05.17.
//
//

import Foundation
import Vapor
import AuthProvider

public extension Droplet {
    public func setupRoutes() throws {
        let staticRoutes = StaticRoutes(view: view)
        let skillRoutes = SkillRoutes(view: view)
        
        try collection(staticRoutes)
        try collection(skillRoutes)
    }
}
