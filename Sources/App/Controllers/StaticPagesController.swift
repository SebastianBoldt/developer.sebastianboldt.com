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
        return try view.make("index")
    }
    
    public func showMusicPage(_ req: Request) throws -> ResponseRepresentable {
        return try view.make("music")
    }
    
    public func showDeveloperPage(_ req: Request) throws -> ResponseRepresentable {
        return try view.make("developer", ["skills": Constants.Seeds.skills])
    }
    
    public func showPrivacyPage(_ req: Request) throws -> ResponseRepresentable {
        return try view.make("privacy")
    }
}
