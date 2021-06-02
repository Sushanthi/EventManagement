//
//  EventsViewControllerTests.swift
//  EventManagementTests
//
//  Created by ur268042 on 5/30/21.
//

import XCTest
@testable import EventManagement

class EventsViewControllerTests: XCTestCase {
    var sut: EventsViewController!
    var apiRequest: APIRequest!
    override func setUp() {
        super.setUp()
        let eventManagementStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.init(for: EventsViewController.self))
        guard let eventManagementVC = eventManagementStoryBoard.instantiateViewController(withIdentifier: "EventsViewController") as? EventsViewController else {
            return
        }
        sut = eventManagementVC
        sut.loadView()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testMockSetup() {
        let event = returnMockEventDetails()
        XCTAssertNotNil(event)
        XCTAssertEqual(event.count, 2)
    }
    
    func mockAPISetup() {
        if let path = Bundle.main.path(forResource: "EventDetails", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                apiRequest = APIRequest()
                let mockURLSession = URLSessionMock()
                mockURLSession.data = data
                apiRequest.session = mockURLSession
            } catch {
                   
            }
        }
    }
    
    func testFetchEvents() {
        mockAPISetup()
        sut.request = apiRequest
        let asyncExpectation = expectation(description: #function)
        sut.fetchEvents()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            asyncExpectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(sut.events)
    }
    
    func testTableView() {
        let events = returnMockEventDetails()
        sut.setupTableView()
        sut.events = events
        XCTAssertEqual(sut.eventsTableView.numberOfRows(inSection: 0), 2)
    }
    
    func testEventTableViewCell() {
        let events = returnMockEventDetails()
        sut.setupTableView()
        sut.events = events
        let indexPath = NSIndexPath(row: 0, section: 0)
        let cell = sut.eventsTableView.dataSource?.tableView(sut.eventsTableView, cellForRowAt: indexPath as IndexPath) as? EventsTableViewCell
        XCTAssertEqual(cell?.titleLabelText.text, "Gary Allan")
        XCTAssertEqual(cell?.locationLabelText.text, "Huntington, WV")
    }
}

extension EventsViewControllerTests {
    func returnMockEventDetails() -> [EventInfo] {
        var event = [EventInfo]()
        if let path = Bundle.main.path(forResource: "EventDetails", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Events.self, from: data)
                event = jsonData.events
                print(event)
                return event
              } catch {
                print("Error reading data from json file")
              }
        }
        return event
    }
}

