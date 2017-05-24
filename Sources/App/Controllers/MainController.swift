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

public protocol ViewRenderProvider {
    var view: ViewRenderer { get set }
    init (view: ViewRenderer)
}

public final class StaticPagesController: ViewRenderProvider {
    public var view: ViewRenderer
    public init(view: ViewRenderer) {
        self.view = view
    }
    
    public func showIndexPage(_ req: Request) throws -> ResponseRepresentable {
        guard let name = req.data["name"]?.string else {
            throw Abort(.badRequest)
        }
        
        return try view.make("index", ["message":"coming soon","name": name])
    }
}
