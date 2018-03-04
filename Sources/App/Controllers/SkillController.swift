//
//  SkillController.swift
//  developer.sebastianboldt.com
//
//  Created by Sebastian Boldt on 25.05.17.
//
//

import Foundation
import Vapor
import HTTP

public final class SkillController: ResourceRepresentable, ViewRenderProvider {
    
    public var view: ViewRenderer
    
    public init(view: ViewRenderer) {
        self.view = view
    }
    
    public func makeResource() -> Resource<Skill> {
        return Resource(index: index, create: create, store: store, show: show, edit: edit, update: update, destroy: destroy)
    }
}

// API Methods
extension SkillController {
    
    public func index(_ request: Request) throws -> ResponseRepresentable {
        return try Skill.all().reversed().makeJSON()
    }
    
    public func show(_ request: Request, skill: Skill) throws -> ResponseRepresentable {
        return skill
    }
    
    public func store(_ request: Request) throws -> ResponseRepresentable {
        let skill = try request.getSkill()
        try skill.save()
        return Response(status: .created)
    }
    
    public func update(_ request: Request, skill: Skill) throws -> ResponseRepresentable {
        let newSkill = try request.getSkill()
        skill.description = newSkill.description
        try skill.save()
        return skill
    }
    
    public func destroy(_ request: Request, skill: Skill) throws -> ResponseRepresentable {
        return Response.init(status: .ok)
    }
    
}

// View Methods
extension SkillController {
    
    // Shows edit form
    public func edit(_ request: Request, skill: Skill) throws -> ResponseRepresentable {
        return "edit"
    }
    
    // Shows the create form
    public func create(_ request: Request) throws -> ResponseRepresentable {
        return "create"
    }
}

extension Request {
    
    // This function extracts the skill object from the json specified
    public func getSkill() throws -> Skill {
        guard let json = json else {
            throw Abort.badRequest
        }
        return try Skill(node: json)
    }
}
