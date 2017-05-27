//
//  Skill.swift
//  developer.sebastianboldt.com
//
//  Created by Sebastian Boldt on 25.05.17.
//
//

import Foundation
import FluentProvider

final public class Skill: Model, ResponseRepresentable {

    var description: String
    
    public let storage = Storage()
    
    init(id: Identifier,description: String) {
        self.description = description
        self.id = id
    }
    
    public init(row: Row) throws {
        description = try row.get("description")
        id = try row.get("id")
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set("description", description)
        return row
    }
}

extension Skill: JSONRepresentable {
    public func makeJSON() throws -> JSON {
        let json = try JSON(node: self)
        return json
    }
}

extension Skill: NodeConvertible {
    
    convenience public init(node: Node) throws {
        let description: String =  try node.get("description")
        let id: Identifier = try node.get("id")
        self.init(id: id, description: description)
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        return try Node(node:["id": id.makeNode(in: context), "description": description])
    }
}

extension Skill: Preparation {
    public static func prepare(_ database: Database) throws {
        try database.create(self) { skills in
            skills.id()
            skills.string("description")
        }
    }
    
    public static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
