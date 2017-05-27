//
//  AccessToken.swift
//  developer.sebastianboldt.com
//
//  Created by Sebastian Boldt on 27.05.17.
//
//

import Vapor
import FluentProvider

public final class AccessToken: Model, ResponseRepresentable {

    public let storage = Storage()

    let token: String
    let userId: Identifier?
    
    var user: Parent<AccessToken, User> {
        return parent(id: userId)
    }
    
    public init(id: Identifier? = nil ,token: String, userId: Identifier?) {
        self.token = token
        self.userId = userId
        self.id = id
    }
    
    public init(row: Row) throws {
        token = try row.get("token")
        userId = try row.get("user_id")
        id = try row.get("id")
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set("token", token)
        try row.set("user_id", userId)
        return row
    }
}

extension AccessToken: JSONRepresentable {
    public func makeJSON() throws -> JSON {
        let json = try JSON(node: self)
        return json
    }
}

extension AccessToken: NodeConvertible {
    
    convenience public init(node: Node) throws {
        let userId: Identifier =  try node.get("user_id")
        let token: String = try node.get("token")
        let id: Identifier = try node.get("id")
        self.init(id: id, token: token, userId: userId)
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        return try Node(node:["id": id.makeNode(in: context), "token": token, "userId": userId.makeNode(in: context)])
    }
}

extension AccessToken: Preparation {
    public static func prepare(_ database: Database) throws {
        try database.create(self) { tokens in
            tokens.id()
            tokens.string("token")
            tokens.foreignId(for: User.self)
        }
    }
    
    public static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
