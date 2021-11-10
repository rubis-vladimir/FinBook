//
//  StorageManager.swift
//  FinBook
//
//  Created by Сперанский Никита on 08.09.2021.
//

import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FinBook")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private let viewContext: NSManagedObjectContext
    
    private init() {
        viewContext = persistentContainer.viewContext
// один из способов инициализировать свойство, при этом свойство можно объявить как "Let"
    }
    
    
    // MARK: - Public Methods - Методы по управлению данными
    
    func fetchData(completion:(Result<[Transact], Error>) -> Void) {
        let fetchRequest: NSFetchRequest<Transact> = Transact.fetchRequest()
        
        do {
            let transactions = try viewContext.fetch(fetchRequest)
            completion(.success(transactions))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func saveData(_ transactionName: String, completion: (Transact) -> Void) {
        let transaction = Transact(context: viewContext)
        //        transaction.cost = transactionName
        completion(transaction)
        saveContext()
    }
    
    func editData(_ task: Transact, newName: String) {
        //            task.name = newName
        saveContext()
    }
    
    func deleteTransaction(_ transaction: Transact) {
        viewContext.delete(transaction)
        saveContext()
    }
    
    // MARK: - Core Data Saving support
    func saveContext () {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
