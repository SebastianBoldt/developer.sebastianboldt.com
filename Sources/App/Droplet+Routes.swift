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
    public func setupRoutes() {
        let mainController = MainController(droplet: self)
        self.get(handler: mainController.showIndexPage)
    }
}
