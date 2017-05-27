//
//  SkillRoutes.swift
//  developer.sebastianboldt.com
//
//  Created by Sebastian Boldt on 25.05.17.
//
//

import Foundation
import Vapor
import AuthProvider

class SkillRoutes: RouteCollection, ViewRenderProvider {
    var view: ViewRenderer
    required init(view: ViewRenderer) {
        self.view = view
    }
    
    func build(_ builder: RouteBuilder) throws {
        let skillsController = SkillController(view: view)
        builder.grouped(TokenAuthenticationMiddleware(User.self)).resource("skills", skillsController)
    }
}
