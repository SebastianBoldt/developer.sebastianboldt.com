//
//  User.swift
//  developer.sebastianboldt.com
//
//  Created by Sebastian Boldt on 27.05.17.
//
//

//
//  Skill.swift
//  developer.sebastianboldt.com
//
//  Created by Sebastian Boldt on 25.05.17.
//
//

import Foundation
import FluentProvider
import AuthProvider

final public class User: Model, ResponseRepresentable, TokenAuthenticatable {
    
    // the token model that should be queried
    // to authenticate this user
    public typealias TokenType = AccessToken
    
    public let storage = Storage()

    var username: String
    var email: String
    var password: String
    
    init(id: Identifier,username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
        self.id = id
    }
    
    public init(row: Row) throws {
        password = try row.get("password")
        username = try row.get("username")
        email = try row.get("email")
        id = try row.get("id")
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set("password", password)
        try row.set("username", username)
        try row.set("email", email)
        return row
    }
}

extension User: JSONRepresentable {
    public func makeJSON() throws -> JSON {
        let json = try JSON(node: self)
        return json
    }
}

extension User: NodeConvertible {
    
    convenience public init(node: Node) throws {
        let userName: String =  try node.get("username")
        let password: String = try node.get("password")
        let email: String = try node.get("email")
        let id: Identifier = try node.get("id")
        self.init(id: id, username: userName, email: email, password: password)
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        return try Node(node:["id": id.makeNode(in: context), "username": username, "email": email, "password": password])
    }
}

extension User: Preparation {
    public static func prepare(_ database: Database) throws {
        try database.create(self) { skills in
            skills.id()
            skills.string("username")
            skills.string("password")
            skills.string("email")

        }
    }
    
    public static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension Request {
    func user() throws -> User {
        return try auth.assertAuthenticated()
    }
}
