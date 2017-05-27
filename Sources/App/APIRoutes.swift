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

class APIRoutes: RouteCollection, ViewRenderProvider {
    
    var view: ViewRenderer
    
    required init(view: ViewRenderer) {
        self.view = view
    }
    
    func build(_ builder: RouteBuilder) throws {
        
        let api = builder.grouped("api")
        let v1 = api.grouped("v1")
        
        let skillsController = SkillController(view: view)
        let authController = AuthenticationController(view: view)
        
        v1.grouped(TokenAuthenticationMiddleware(User.self)).resource("skills", skillsController)
        v1.post("authtoken", handler: authController.getAuthenticationToken)
    }
}
