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
    static func create(name: String) -> FruitEntity {
        let entity = CoreDataRepository()
            .entity((String(describing: FruitEntity.self))) as! FruitEntity
        entity.name = name
        return entity
    }
}
