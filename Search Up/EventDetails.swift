//
//  EventDetails.swift
//  Search Up
//
//  Created by John Russo on 5/26/22.
//

import SwiftUI

struct EventDetails: View {
    @State var title: String
    @State var city: String
    @State var state: String
    @State var date: String
    @State var imageUrl: String
    @State var favorited = false
    @State var id: Int
    @State var favoritesArray = UserDefaults.standard.array(forKey: "favorites") ?? []
    @State var favoritesArrayHold = []
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
            ZStack {
                VStack {
                    Rectangle()
                        .frame(height: 0)
                        .background(Color(UIColor(hue: 0.5389, saturation: 0.48, brightness: 0.29, alpha: 1.0)))
                    HStack{
                        Text(title)
                        if favorited{
                            Image(systemName: "heart.fill")
                                .foregroundColor(Color.red)
                                .onTapGesture {
                                    favorited = false
                                    favoritesArrayHold = favoritesArray.filter(){$0 as! Int != id}
                                    UserDefaults.standard.removeObject(forKey: "favorites")
                                    UserDefaults.standard.set(favoritesArrayHold, forKey: "favorites")


                                }
                            
                        } else {
                            Image(systemName: "heart")
                                .foregroundColor(Color.red)
                                .onTapGesture {
                                    favorited = true
                                    favoritesArrayHold = UserDefaults.standard.array(forKey: "favorites") ?? []
                                    UserDefaults.standard.removeObject(forKey: "favorites")
                                    favoritesArrayHold.append(id)
                                    UserDefaults.standard.set(favoritesArrayHold, forKey: "favorites")
                                }
                        }
                    }
                    
                        .navigationBarTitleDisplayMode(.inline)
                                .toolbar {
                                    ToolbarItem(placement: .principal) {
                                        HStack {
                                            Image(systemName: "chevron.left")
                                                .foregroundColor(.white)
                                                .offset(x: 30)
                                                .onTapGesture {
                                                    presentationMode.wrappedValue.dismiss()
                                                }
                                            Text("Details")
                                                .offset(x: -20)
                                                .frame(width: UIScreen.main.bounds.width)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            
                                        }
                                        
                                        
                                    }
                                    
                                }
                        .padding()
                    URLImageDetail(urlString: imageUrl)
                    ZStack(alignment: .topLeading){
                        Color.clear
                            .frame(height: 40)
                                VStack(alignment: .leading) {
                                    Text(date)
                                        .bold()
                                        .font(.system(size: 30))
                                    Text("\(city), \(state)")
                                        .foregroundColor(.gray)
                                }
                    }
                    Spacer()
                }.onAppear{
                    favoritesArray = UserDefaults.standard.array(forKey: "favorites") ?? []
                    for fav in favoritesArray{
                        if fav as! Int == id{
                            favorited = true
                        }
                    }
                    
                }
                .font(.title2)
            }.navigationBarBackButtonHidden(true)

    }
}

struct EventDetails_Previews: PreviewProvider {
    static var previews: some View {
        EventDetails(title: "Title", city: "City", state: "State", date: "Date", imageUrl: "imageURL", id: 0)
    }
}
