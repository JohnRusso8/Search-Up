//
//  ContentView.swift
//  Search Up
//
//  Created by John Russo on 5/25/22.
//

import SwiftUI

struct ContentView: View {

    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    HStack{
                        
                        SearchBar(searchText: $viewModel.searchText)
                            .onSubmit {
                                viewModel.fetch()
                            }
                            .padding()
                        Text("Cancel")
                        .padding(.trailing)
                        .opacity(viewModel.searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            viewModel.searchText = ""
                            UIApplication.shared.endEditing()
                            viewModel.fetch()
                        }
                        
                    }.background(Color(UIColor(hue: 0.5389, saturation: 0.48, brightness: 0.29, alpha: 1.0)))
                }
                ScrollView{
                VStack{
                    
                    ForEach(viewModel.events, id: \.self) { event in
                        EventCardView(title: event.title, city: event.venue.city, date: event.datetime_utc, state: event.venue.state, urlImage: grabImageUrl(array: event.performers), id: event.id)
                        
                    }
                    
                }
            }
                
        }

            .onAppear{
                viewModel.fetch()
            }
            .navigationBarHidden(true)
        }
        
    }
    
    func grabImageUrl(array: [Performer]) -> String{
        var imageURL = ""
        for imageUrls in array {
            imageURL = imageUrls.image ?? ""
        }
        
        
        return imageURL
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
