//
//  ListsTests.swift
//  App
//
//  Created by Sergei Perevoznikov on 13/01/2017.
//  Copyright © 2017 Sergei Perevoznikov. All rights reserved.
//

import XCTest
import ShoppingData
import ShoppingModels
import Random

class ListsTests: XCTestCase, ListsDelegate {
    var stack: Stack = Stack(entities: [ListEntity()])
    
    var lists: Lists!
    
    var insertAction: ((IndexPath) -> Void)?
    var deleteAction: ((IndexPath) -> Void)?
    var updateAction: ((IndexPath, IndexPath?) -> Void)?
    
    override func setUp() {
        super.setUp()
        lists = Lists(stack: stack, delegate: self)
    }
    
    private func add(id: String, name: String) {
        lists.add(List(id: id, name: name))
    }
    
    private func delete(id: String, name: String) {
        lists.delete(List(id: id, name: name))
    }
    
    private func update(id: String, name: String) {
        lists.update(List(id: id, name: name))
    }
    
    func objectsInserted(indexPath: IndexPath) {
        insertAction?(indexPath)
    }
    
    func objectsDeleted(indexPath: IndexPath) {
        deleteAction?(indexPath)
    }
    
    func save() {
        lists.save()
    }
    
    func objectsUpdated(indexPath: IndexPath, newIndexPath: IndexPath?) {
        updateAction?(indexPath, newIndexPath)
    }
    
    func objectsWillChange() {
        
    }
    
    func objectsDidChange(objects: [ListProtocol]) {
        
    }
    
    func objectsDidChange(objects: [Any]) {
        
    }
    
    func testInsertIndex() {
        let id = Random.string()
        let name = Random.string()
        let ex = expectation(description: "")
        add(id: id, name: name)
        insertAction = { index in
            XCTAssertEqual(index.row, 0)
            ex.fulfill()
        }
        save()
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testInsertIndexOrder() {
        add(id: Random.string(), name: "0")
        add(id: Random.string(), name: "1")
        add(id: Random.string(), name: "3")
        add(id: Random.string(), name: "4")
        save()
        
        let ex = expectation(description: "")
        add(id: Random.string(), name: "2")
        insertAction = { index in
            XCTAssertEqual(index.row, 2)
            ex.fulfill()
        }
        save()
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testInsertIndexBackOrder() {
        add(id: Random.string(), name: "0")
        add(id: Random.string(), name: "4")
        add(id: Random.string(), name: "3")
        add(id: Random.string(), name: "2")
        save()
        
        let ex = expectation(description: "")
        add(id: Random.string(), name: "1")
        insertAction = { index in
            XCTAssertEqual(index.row, 1)
            ex.fulfill()
        }
        save()
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testDeleteIndex() {
        let id = Random.string()
        let name = "1"
        
        add(id: Random.string(), name: "0")
        add(id: Random.string(), name: "4")
        add(id: Random.string(), name: "3")
        add(id: id, name: name)
        add(id: Random.string(), name: "2")
        save()
        
        let ex = expectation(description: "")
        delete(id: id, name: Random.string())
        deleteAction = { index in
            XCTAssertEqual(index.row, 1)
            ex.fulfill()
        }
        save()
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testUpdateIndex() {
        let id = Random.string()
        let name = "11"
        
        add(id: Random.string(), name: "0")
        add(id: Random.string(), name: "4")
        add(id: Random.string(), name: "3")
        add(id: id, name: "1")
        add(id: Random.string(), name: "2")
        save()
        
        let ex = expectation(description: "")
        update(id: id, name: name)
        updateAction = { index, _ in
            XCTAssertEqual(index.row, 1)
            ex.fulfill()
        }
        save()
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testMoveIndex() {
        let id = Random.string()
        let name = "51\(Random.string())"
        
        add(id: Random.string(), name: "00")
        add(id: Random.string(), name: "40")
        add(id: Random.string(), name: "30")
        add(id: id, name: "10")
        add(id: Random.string(), name: "20")
        save()
        
        let ex = expectation(description: "")
        update(id: id, name: name)
        updateAction = { index, _ in
            XCTAssertEqual(index.row, 1)
            ex.fulfill()
        }
        save()
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testMoveNewIndex() {
        let id = Random.string()
        let name = "41\(Random.string())"
        
        add(id: Random.string(), name: "00")
        add(id: Random.string(), name: "40")
        add(id: Random.string(), name: "30")
        add(id: id, name: "10")
        add(id: Random.string(), name: "20")
        save()
        
        let ex = expectation(description: "")
        update(id: id, name: name)
        updateAction = { _, newIndex in
            XCTAssertEqual(newIndex?.row, 4)
            ex.fulfill()
        }
        save()
        waitForExpectations(timeout: 0.5, handler: nil)
    }
}
