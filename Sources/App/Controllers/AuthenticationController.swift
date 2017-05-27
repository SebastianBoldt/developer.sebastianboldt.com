//
//  AuthenticationController.swift
//  developer.sebastianboldt.com
//
//  Created by Sebastian Boldt on 27.05.17.
//
//

import Foundation
import Vapor

public class AuthenticationController: ViewRenderProvider {
    
    public var view: ViewRenderer
    
    required public init(view: ViewRenderer) {
        self.view = view
    }
    
    func getAuthenticationToken(_ request: Request) throws -> ResponseRepresentable {
        
        let user = try validUserFromRequest(request: request)
        
        guard let token = try user.accessToken() else {
            return try createAndStoreToken(forUser: user)
        }
        
        return token
    }
    
    private func createAndStoreToken(forUser user: User) throws -> AccessToken {
        let tokenString = UUID().uuidString
        let accessToken = AccessToken(token: tokenString, userId: user.id)
        try accessToken.save()
        return accessToken
    }
    
    private func validUserFromRequest(request: Request) throws -> User {
        guard let username = request.data["username"]?.string  else {
            throw Abort.badRequest
        }
        
        guard let password = request.data["password"]?.string else {
            throw Abort.badRequest
        }
        
        guard let userWithUsername: User = try User.all().filter({ $0.username == username }).first else {
            throw Abort.unauthorized
        }
        
        guard userWithUsername.password == password else {
            throw Abort.unauthorized
        }
        
        return userWithUsername
    }

}
