//
//  main.swift
//  Store
//
//  Created by Ted Neward on 2/29/24.
//

import Foundation

protocol SKU {
    var name: String { get }
    func price() -> Int
}

class Item: SKU {
    var name: String
    var priceEach: Int

    init(name: String, priceEach price: Int) {
        self.name = name
        self.priceEach = price
    }

    func price() -> Int {
        return priceEach
    }
}

class Receipt {
    var itemsList: [SKU]

    init() {
        self.itemsList = []
    }

    func addItem(_ item: SKU) {
        itemsList.append(item)
    }

    func items() -> [SKU] {
        return itemsList
    }

    func output() -> String {
            var receiptString = "Receipt:\n"
            
            for item in itemsList {
                let priceInDollars = Double(item.price()) / 100.0
                let formattedPrice = String(format: "$%.2f", priceInDollars)
                receiptString += "\(item.name): \(formattedPrice)\n"
            }
            
            let totalInDollars = Double(total()) / 100.0
            let formattedTotal = String(format: "$%.2f", totalInDollars)
            receiptString += "------------------\nTOTAL: \(formattedTotal)"
            
            return receiptString
        }

    func total() -> Int {
        return itemsList.reduce(0) { $0 + $1.price() }
    }
}

class Register {
    var receipt: Receipt

    init() {
        self.receipt = Receipt()
    }

    func scan(_ item: SKU) {
        receipt.addItem(item)
    }

    func subtotal() -> Int {
        return receipt.total()
    }

    func total() -> Receipt {
        let completed = receipt
        self.receipt = Receipt()
        return completed
    }
    
    func twoForOne(_ saleItem: String) {
        var itemCounter = 0
        var indexToRemove: Int?
        
        for (index, item) in receipt.items().enumerated() {
            if item.name == saleItem && itemCounter == 2 {
                indexToRemove = index
                itemCounter = 0
                receipt.itemsList.remove(at: indexToRemove!)
                let newItem = Item(name: item.name, priceEach: 000)
                receipt.addItem(newItem)
            } else if item.name == saleItem {
                itemCounter += 1
            }
        }
    }
}

class Store {
    let version = "0.1"
    func helloWorld() -> String {
        return "Hello world"
    }
}
