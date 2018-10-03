import Vapor

public func routes(_ router: Router) throws {
    router.get() { req -> Future<View> in
        return try req.view().render("index")
    }
    
    router.get("developer") { req -> Future<View> in
        return try req.view().render("developer",["skills": Constants.Seeds.skills])
    }
    
    router.get("music") { req -> Future<View> in
        return try req.view().render("music")
    }
    
    router.get("privacy") { req -> Future<View> in
        return try req.view().render("privacy")
    }
}
