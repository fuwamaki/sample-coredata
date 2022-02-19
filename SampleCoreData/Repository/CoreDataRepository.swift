//
//  CoreDataRepository.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/19.
//

import UIKit
import CoreData

class CoreDataRepository {

    init() {}

    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Korenani")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private var context: NSManagedObjectContext {
        return CoreDataRepository.persistentContainer.viewContext
    }

    func add(_ object: NSManagedObject) {
        context.insert(object)
    }

//    func update(_ entity: TestEntity, newMessage: String) {
//        entity.message = newMessage
//    }

    func delete(_ object: NSManagedObject) {
        context.delete(object)
    }
}

// MARK: fetch
extension CoreDataRepository {
    func array<T: NSManagedObject>(_ name: String) -> [T] {
        do {
            let request = NSFetchRequest<T>(entityName: name)
            return try context.fetch(request)
        } catch {
            fatalError()
        }
    }
}

// MARK: for Create
extension CoreDataRepository {
    func entity<T: NSManagedObject>(_ name: String) -> T {
        let entityDescription = NSEntityDescription.entity(forEntityName: name, in: context)!
        return T(entity: entityDescription, insertInto: nil)
    }
}

// MARK: REST functions
extension CoreDataRepository {
    func saveJob() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            debugPrint("Error: \(error), \(error.userInfo)")
        }
    }
}

// MARK: async/await REST functions
extension CoreDataRepository {
    func save() async throws {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            debugPrint("Error: \(error), \(error.userInfo)")
            throw error
        }
    }

    func rollback() async throws {
        guard context.hasChanges else { return }
        context.rollback()
    }
}

// MARK: seeds
//extension CoreDataRepository {
//    func seeds() {
//        guard array(String(describing: TestEntity.self)).isEmpty else { return }
//        ["A", "B", "C", "D", "E", "F", "G", "H", "I"]
//            .compactMap { Test(message: $0).entity }
//            .forEach { add($0) }
//    }
//}
