//
//  ShapeEntity+CoreDataClass.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/22.
//
//

import Foundation
import CoreData

@objc(ShapeEntity)
public class ShapeEntity: NSManagedObject {
    static func new(shapeName: String) -> ShapeEntity {
        let entity: ShapeEntity = CoreDataRepository.entity((String(describing: ShapeEntity.self)))
        entity.name = shapeName
        return entity
    }

    func update(newName: String) {
        self.name = newName
    }
}
