//
//  File.swift
//  developer.sebastianboldt.com
//
//  Created by Sebastian Boldt on 24.05.17.
//
//

import Foundation
import Vapor

class StaticRoutes: RouteCollection, ViewRenderProvider {
    var view: ViewRenderer
    required init(view: ViewRenderer) {
        self.view = view
    }
    
    func build(_ builder: RouteBuilder) throws {
        let staticPagesController = StaticPagesController(view: view)        
        builder.get( handler: staticPagesController.showIndexPage)
        builder.get("developer" ,handler: staticPagesController.showDeveloperPage)
        builder.get("music" ,handler: staticPagesController.showMusicPage)
        
        // A Web-Admin area will come later, currently we are just using the api to change the Website
        //builder.get("admin", handler: authController.showLoginPage)
    }
}
