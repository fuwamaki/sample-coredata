//
//  FruitEntity+CoreDataProperties.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/20.
//
//

import Foundation
import CoreData

extension FruitEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FruitEntity> {
        return NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
    }

    @NSManaged public var name: String?
}

extension FruitEntity : Identifiable {}
