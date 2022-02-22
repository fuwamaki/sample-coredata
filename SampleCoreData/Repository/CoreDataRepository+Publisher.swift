//
//  CoreDataRepository+Publisher.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/22.
//

import CoreData

extension CoreDataRepository {
    static func coreDataPublisher<T: NSManagedObject>() -> CoreDataPublisher<T> {
        return CoreDataPublisher(
            request: NSFetchRequest<T>(entityName: String(describing: T.self)),
            context: context
        )
    }
}
