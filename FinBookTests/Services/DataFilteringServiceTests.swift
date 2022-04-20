//
//  DataFilteringServiceTests.swift
//  DataFilteringServiceTests
//
//  Created by Владимир Рубис on 02.04.2022.
//

import XCTest
@testable import FinBook
import CoreData

class DataFilteringServiceTests: XCTestCase {
    
    var sut: DataFilteringService!
    var transactions: [Transact] = []
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Transact")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    private var viewContext: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        sut = DataFilteringService()
        viewContext = persistentContainer.viewContext
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    /// Создаем и добавляем транзакции в массив
    private func setupParameters() {
        transactions.append(createTransact(date: "03-10-2022 09:08:00",
                                           category: "Машина",
                                           cost: 1000,
                                           isIncome: false))
        transactions.append(createTransact(date: "03-02-2022 20:08:00",
                                           category: "Одежда",
                                           cost: 500,
                                           isIncome: false))
        transactions.append(createTransact(date: "04-03-2022 17:08:00",
                                           category: "Продукты",
                                           cost: 1500,
                                           isIncome: false))
        transactions.append(createTransact(date: "04-10-2022 12:08:00",
                                           category: "Машина",
                                           cost: 2000,
                                           isIncome: false))
        transactions.append(createTransact(date: "04-15-2022 15:08:00",
                                           category: "Зарплата",
                                           cost: 10000,
                                           isIncome: true))
    }
    
    /// Cборка транзакции для тестирования
    private func createTransact(date: String,
                                category: String,
                                cost: Double,
                                isIncome: Bool) -> Transact {
        let transact = Transact(context: viewContext)
        
        transact.date = getDateFromString(dateString: date)
        transact.category = category
        transact.cost = cost
        transact.incomeTransaction = isIncome
        
        return transact
    }
    
    /// Конвертирует `String` в `Date`
    private func getDateFromString(dateString: String) -> Date {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        let date = formatter.date(from: dateString)
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date ?? Date())
        let newDate = calendar.date(from: dateComponents) ?? Date()
        return newDate
    }
    
    func testGetDataInPersentage1() {
        
        //arange
        var startDate: Date {
            getDateFromString(dateString: "03-02-2022 00:00:00")
        }
        var endDate: Date {
            getDateFromString(dateString: "04-10-2022 20:00:00")
        }
        setupParameters()
        
        //act
        let data = sut.getDataInPercentage(from: transactions,
                                           from: startDate,
                                           to: endDate,
                                           isIncome: false)
    
        //assert
        /// Количество элементов в массиве - `3`
        XCTAssertEqual(data.count, 3)
        /// Процент для 1-го элемента в массиве - `60%`
        XCTAssertEqual(data[0].1, 60)
        /// Название последней категории в массиве - `Одежда`
        XCTAssertEqual(data.last?.0, "Одежда")
    }
    
    func testGetDataInPersentage2() {
        
        //arange
        var startDate: Date {
            getDateFromString(dateString: "03-02-2022 00:00:00")
        }
        var endDate: Date {
            getDateFromString(dateString: "04-10-2022 20:00:00")
        }
        setupParameters()
        
        //act
        let data = sut.getDataInPercentage(from: transactions,
                                           from: startDate,
                                           to: endDate,
                                           isIncome: true)
        
        //assert
        /// Массив пустой
        XCTAssertTrue(data.isEmpty)
    }

    func testGetDataInPersentage3() {
        
        //arange
        var startDate: Date {
            getDateFromString(dateString: "04-15-2022 00:00:00")
        }
        var endDate: Date {
            getDateFromString(dateString: "04-15-2022 20:00:00")
        }
        setupParameters()
        
        //act
        let data = sut.getDataInPercentage(from: transactions,
                                           from: startDate,
                                           to: endDate,
                                           isIncome: true)
        
        //assert
        /// Название категории 1-го элемента - `Зарплата`
        XCTAssertEqual(data[0].0, "Зарплата")
        /// Количество элементов в массиве - `1`
        XCTAssertEqual(data.count, 1)
    }
    
}
