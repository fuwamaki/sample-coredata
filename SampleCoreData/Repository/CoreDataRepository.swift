//
//  CoreDataRepository.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/19.
//

import CoreData

class CoreDataRepository {

    init() {}

    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SampleCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    internal static var context: NSManagedObjectContext {
        return CoreDataRepository.persistentContainer.viewContext
    }
}

// MARK: for Create
extension CoreDataRepository {
    static func entity<T: NSManagedObject>(_ name: String) -> T {
        let entityDescription = NSEntityDescription.entity(forEntityName: name, in: context)!
        return T(entity: entityDescription, insertInto: nil)
    }
}

// MARK: CRUD
extension CoreDataRepository {
    static func array<T: NSManagedObject>(_ name: String) -> [T] {
        do {
            let request = NSFetchRequest<T>(entityName: name)
            return try context.fetch(request)
        } catch {
            fatalError()
        }
    }

    static func add(_ object: NSManagedObject) {
        context.insert(object)
    }

    static func delete(_ object: NSManagedObject) {
        context.delete(object)
    }
}

// MARK: context CRUD
extension CoreDataRepository {
    static func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            debugPrint("Error: \(error), \(error.userInfo)")
        }
    }

    static func rollback() {
        guard context.hasChanges else { return }
        context.rollback()
    }
}

// MARK: seeds
extension CoreDataRepository {
    static func seedsFruit() {
        guard array(String(describing: FruitEntity.self)).isEmpty else { return }
        ["Apple", "Banana", "Peach", "Orange", "Grape", "Pineapple", "Melon"]
            .compactMap { FruitEntity.new(fruitName: $0) }
            .forEach { add($0) }
    }

    static func seedsShape() {
        guard array(String(describing: ShapeEntity.self)).isEmpty else { return }
        ["Triangle", "Rectangle", "Circle", "Oval", "Square"]
            .compactMap { ShapeEntity.new(shapeName: $0) }
            .forEach { add($0) }
    }
}
