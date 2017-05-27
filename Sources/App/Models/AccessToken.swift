//
//  AccessToken.swift
//  developer.sebastianboldt.com
//
//  Created by Sebastian Boldt on 27.05.17.
//
//

import Vapor
import FluentProvider

public final class AccessToken: Model {

    public let storage = Storage()

    let token: String
    let userId: Identifier
    
    var user: Parent<AccessToken, User> {
        return parent(id: userId)
    }
    
    init(id: Identifier,token: String, userId: Identifier) {
        self.token = token
        self.userId = userId
        self.id = id
    }
    
    public init(row: Row) throws {
        token = try row.get("token")
        userId = try row.get("userId")
        id = try row.get("id")
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set("token", token)
        try row.set("userId", userId)
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
        let userId: Identifier =  try node.get("userId")
        let token: String = try node.get("token")
        let id: Identifier = try node.get("id")
        self.init(id: id, token: token, userId: userId)
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        return try Node(node:["id": id.makeNode(in: context), "token": token, "userId": userId])
    }
}

extension AccessToken: Preparation {
    public static func prepare(_ database: Database) throws {
        try database.create(self) { skills in
            skills.id()
            skills.string("token")
        }
    }
    
    public static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
