import Vapor
/// Redirects reverse proxy requests originating as http to https.
///
///     middlewareConfig = MiddlewareConfig()
///     middlewareConfig.use(XFPMiddleware())
///     services.register(middlewareConfig)
///
/// Register middleware in services.
public struct XFPMiddleware: Middleware {
    
    let enabled: Bool
    /// Creates a new `XFPMiddleware`.
    public init(enabled: Bool = true) {
        self.enabled = enabled
    }
    
    /// See `Middleware`.
    public func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {
        guard enabled, request.http.headers.firstValue(name: HTTPHeaderName("X-Forwarded-Proto")) == "http" else {
            return try next.respond(to: request)
        }
        let redirectPath = request.http.urlString.replacingOccurrences(of: "http://", with: "https://")
        return request.future(request.redirect(to: redirectPath, type: RedirectType.temporary))
    }
}
