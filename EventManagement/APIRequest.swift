//
//  APIRequest.swift
//  EventManagement
//
//  Created by ur268042 on 5/29/21.
//

import Foundation

struct APIRequest {
    let client_id = "MjIwMzc3MTJ8MTYyMjIxNjQyNi4wODU2MDg1"
    var resourceURL: URL
    var session: URLSession!
    init() {
        let resourceURLString = "https://api.seatgeek.com/2/events?client_id=\(client_id)"
        guard let resourceURL = URL(string: resourceURLString) else { fatalError() }
        self.resourceURL = resourceURL
        self.session = URLSession.shared
    }
    
    func getEvents(completion: @escaping([EventInfo], Error?) -> Void) {
        session.dataTask(with: resourceURL) { data, response, error in
            guard let response = data else {
                completion([], error!)
                return
            }
            do {
                let decoder = JSONDecoder()
                let eventResponse = try decoder.decode(Events.self, from: response)
                let eventDetails = eventResponse.events
                completion(eventDetails, nil)
            } catch {
                completion([], error)
            }
        }.resume()
    }
}
