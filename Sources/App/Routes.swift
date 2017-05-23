import Vapor

final class Routes: RouteCollection {
    func build(_ builder: RouteBuilder) throws {
        builder.get("api") { request in
            return try JSON(node: ["message": "Hello Vapor"])
        }
    }
}

/// Since Routes doesn't depend on anything
/// to be initialized, we can conform it to EmptyInitializable
///
/// This will allow it to be passed by type.
extension Routes: EmptyInitializable { }
