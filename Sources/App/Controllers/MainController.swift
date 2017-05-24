//
//  MainController.swift
//  developer.sebastianboldt.com
//
//  Created by Sebastian Boldt on 24.05.17.
//
//

import Foundation
import Vapor
import HTTP

public protocol DropletProvider {
    var droplet: Droplet { get set }
    init (droplet: Droplet)
}

public final class MainController: DropletProvider {
    public var droplet: Droplet
    
    public init(droplet: Droplet) {
        self.droplet = droplet
    }
    
    public func showIndexPage(_ req: Request) throws -> ResponseRepresentable {
        guard let name = req.data["name"]?.string else {
            throw Abort(.badRequest)
        }
        
        return try droplet.view.make("index", ["message":"coming soon","name": name])
    }
}
