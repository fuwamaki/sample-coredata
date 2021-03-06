//
//  FruitEntity+CoreDataClass.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/20.
//
//

import Foundation
import CoreData

@objc(FruitEntity)
public class FruitEntity: NSManagedObject {
    static func new(fruitName: String) -> FruitEntity {
        let entity: FruitEntity = CoreDataRepository.entity((String(describing: FruitEntity.self)))
        entity.name = fruitName
        return entity
    }

    func update(newName: String) {
        self.name = newName
    }
}
