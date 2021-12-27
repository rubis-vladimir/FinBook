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
// viewContext - база данных восстановленная из памяти / контекст главной очереди
// один из способов инициализировать свойство, при этом свойство можно объявить как "Let"
    }
    
    
    // MARK: - Public Methods - Методы по управлению данными
    
    func fetchData() -> [Transact] {
        // создали запрос к базе данных "fetchRequest" - выбрать из базы все объекты с типом Transact
        let fetchRequest: NSFetchRequest<Transact> = Transact.fetchRequest()
//        // сортировка выводимых данных по дате
//        let sort = NSSortDescriptor(key: #keyPath(Transact.date), ascending: true)
//        fetchRequest.sortDescriptors = [sort]
        do {
            let transactions = try viewContext.fetch(fetchRequest)
            return transactions // при удаче возвращаем массив транзакций
        } catch let error {
            print (error)
            return []  // при неудаче возвращаем пустой массив
        }
    }
    
    func saveData(newTransaction: Transact, completion: (Transact) -> Void) {
        var transaction = Transact(context: viewContext)
        transaction = newTransaction
        completion(transaction)
        saveContext()
        print("---------- сохранили транзакцию \(newTransaction.descr ?? "")")
    }
    
    //    Собрать новую транзакцию из элементов
    func createTransact(cost: Double, description: String, category: String,
                        date: Date, note: String, income: Bool) -> Transact {
        let transaction = Transact(context: viewContext)
        transaction.cost = cost
        transaction.descr = description
        transaction.category = category
        transaction.date = date
        transaction.note = note
        transaction.incomeTransaction = income
        print("----------Собрали и сохранили новую транзакцию")
        saveContext()

        return transaction
    }

    
    func editData(editingTransaction: Transact, from newTransaction: Transact) {
        print("----------Отредактировал транзакцию \(editingTransaction.descr ?? "") [удалили её]")
        deleteTransaction(editingTransaction)
        
        saveData(newTransaction: editingTransaction)  { transaction in }    //R800 ------------------------------------------------

        saveContext()
        print("---------- на транзакцию \(newTransaction.descr ?? "")")
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
