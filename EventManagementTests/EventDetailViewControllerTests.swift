//
//  EventDetailViewControllerTests.swift
//  EventManagementTests
//
//  Created by ur268042 on 5/30/21.
//

import XCTest
@testable import EventManagement

class EventDetailViewControllerTests: XCTestCase {
    var sut: EventDetailViewController!
    
    override func setUp() {
        super.setUp()
        let eventDetailStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.init(for: EventsViewController.self))
        guard let eventDetailVC = eventDetailStoryBoard.instantiateViewController(withIdentifier: "EventDetailViewController") as? EventDetailViewController else {
            return
        }
        sut = eventDetailVC
        sut.eventDetails = setupMockEvent()
        sut.formattedDate = "Sunday, 25 June 2021 07:30 AM"
        sut.loadView()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSetupView() {
        sut.setupView()
        XCTAssertEqual(sut.titleLabel.text, "Gary Allan")
        XCTAssertEqual(sut.locationLabel.text, "Huntington, WV")
        XCTAssertEqual(sut.timeLabel.text, "Sunday, 25 June 2021 07:30 AM")
        XCTAssertNotNil(sut.eventImageView)
        XCTAssertEqual(sut.eventId, "5097673")
    }
    
    func testOnClickOfFavouriteButton_OnIsFavouriteFalse() {
        sut.setupView()
        sut.onClickOfFavouriteButton((Any).self)
        let imageFromButton : UIImage = sut.favoriteEventButton.image(for: UIControl.State.normal)!
        XCTAssertEqual(imageFromButton, UIImage(systemName: "heart.fill"))
        XCTAssertTrue(UserDefaults.standard.bool(forKey: sut.eventId))
    }
    
    func testOnClickOfFavouriteButton_OnIsFavouriteTrue() {
        sut.setupView()
        sut.isFavouriteButtonClicked = true
        sut.onClickOfFavouriteButton((Any).self)
        let imageFromButton : UIImage = sut.favoriteEventButton.image(for: UIControl.State.normal)!
        XCTAssertEqual(imageFromButton, UIImage(systemName: "heart"))
        XCTAssertFalse(UserDefaults.standard.bool(forKey: sut.eventId))
    }
    
    func setupMockEvent() -> EventInfo {
        var mockEvent = EventInfo()
        var mockPerformer =  PerformersInfo()
        mockPerformer.image = "https://seatgeek.com/images/performers-landscape/gary-allan-65aa73/767/20260/huge.jpg"
        mockPerformer.home_team = false
        mockEvent.title = "Gary Allan"
        mockEvent.id = 5097673
        mockEvent.venue.display_location = "Huntington, WV"
        mockEvent.performers.append(mockPerformer)
        return mockEvent
    }
}
