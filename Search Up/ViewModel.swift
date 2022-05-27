//
//  ViewModel.swift
//  Search Up
//
//  Created by John Russo on 5/25/22.
//

import SwiftUI

struct Events: Hashable, Codable{
    let events: [Event]
    
}
struct Event: Hashable, Codable {
    let id: Int
    let title: String
    let datetime_utc: String
    let venue: (Venue)
    let performers: [Performer]
}
struct Performer: Hashable, Codable{
    let image: String?
}
struct Venue: Hashable, Codable{
    
    let state: String
    let city: String
}



class ViewModel: ObservableObject{
    
    @Published var events: [Event] = []
    @Published var searchText = ""
//    init(){
//        addSubscribers()
//    }
    
    func fetch() {
        
        guard let url = URL(string: "https://api.seatgeek.com/2/events?client_id=MjcxMjI5ODh8MTY1MzM5MTc1MS4wMjI2OTg2&q=\(searchText)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, _, error in
            guard let data = data, error == nil else {
                
                return
            }
            
            do {
                let events = try JSONDecoder().decode(Events.self, from: data)

                DispatchQueue.main.async {
                    self.events = events.events
 
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}
