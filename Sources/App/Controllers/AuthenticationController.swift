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
}

extension AuthenticationController {
    public func getAuthenticationToken(_ request: Request) throws -> ResponseRepresentable {
        let user = try validUserFromRequest(request: request)
        guard let token = try user.accessToken() else {
            return try createAndStoreToken(forUser: user)
        }
        return token
    }
    
    public func changePassword(_ request: Request) throws -> ResponseRepresentable {
        // Check if old password was specified
        guard let oldPassword = request.data["password"]?.string  else {
            throw Abort.badRequest
        }
        
        // Check if old password is valid 
        let user = try request.user()
        
        guard user.password == oldPassword else {
            throw Abort.badRequest
        }
        
        // Check if new password is safe
        //TODO: Add regex shizzle over here
        guard let newPassword = request.data["new-password"]?.string else {
            throw Abort.badRequest
        }
        
        guard let newRepeatedPassword = request.data["repeat-password"]?.string else {
            throw Abort.badRequest
        }
        
        // Check if repeated password is valid 
        guard newRepeatedPassword == newPassword else {
            throw Abort.badRequest
        }
        // update password of user
        
        user.password = newRepeatedPassword
        try user.save()
        
        // Respond with success
        
        return Response.init(status: .accepted)
    }
}


// Helper
extension AuthenticationController {
    
    fileprivate func createAndStoreToken(forUser user: User) throws -> AccessToken {
        let tokenString = UUID().uuidString
        let accessToken = AccessToken(token: tokenString, userId: user.id)
        try accessToken.save()
        return accessToken
    }
    
    fileprivate func validUserFromRequest(request: Request) throws -> User {
        
        // Check if user name and passwort were specified
        guard let username = request.data["username"]?.string  else {
            throw Abort.badRequest
        }
        
        guard let password = request.data["password"]?.string else {
            throw Abort.badRequest
        }
        
        // Check if userName and password are valid
        guard let userWithUsername: User = try User.all().filter({ $0.username == username }).first else {
            throw Abort.unauthorized
        }
        
        guard userWithUsername.password == password else {
            throw Abort.unauthorized
        }
        
        return userWithUsername
    }
}
