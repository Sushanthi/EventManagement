//
//  EventModel.swift
//  EventManagement
//
//  Created by ur268042 on 5/29/21.
//

import Foundation

import Foundation

struct Events: Decodable {
    var events: [EventInfo]
    init() {
        self.events = [EventInfo]()
    }
}

struct EventInfo: Decodable {
    var type: String
    var id: Int
    var datetime_local: String
    var title: String
    var venue: VenuInfo
    var performers: [PerformersInfo]
    
    init() {
        self.type = ""
        self.id = 0
        self.datetime_local = ""
        self.title = ""
        self.venue = VenuInfo()
        self.performers = [PerformersInfo]()
    }
}

struct VenuInfo: Decodable {
    var display_location: String
    init() {
        self.display_location = ""
    }
}

struct PerformersInfo: Decodable {
    var image: String
    var home_team: Bool?
    init() {
        self.image = ""
        self.home_team = false
    }
}
