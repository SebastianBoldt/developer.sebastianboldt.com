//
//  Database+Extension.swift
//  developer.sebastianboldt.com
//
//  Created by Sebastian Boldt on 27.05.17.
//
//

import Foundation
import FluentProvider

public extension Database {
    public func seed<T: Entity>(_ objects: [T]) throws {
        try transaction { conn in
            let query = try T.makeQuery(conn)
            
            try objects.forEach {
                try query.save($0)
            }
        }
    }
}
