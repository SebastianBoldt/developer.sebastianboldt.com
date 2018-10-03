import Vapor

public func routes(_ router: Router) throws {
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("developer") { req in
        return "Developer"
    }
    
    router.get("music") { req in
        return "Music"
    }
}
