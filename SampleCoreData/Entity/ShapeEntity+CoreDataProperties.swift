//
//  ShapeEntity+CoreDataProperties.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/22.
//
//

import Foundation
import CoreData

extension ShapeEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShapeEntity> {
        return NSFetchRequest<ShapeEntity>(entityName: "ShapeEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
}

extension ShapeEntity : Identifiable {}
