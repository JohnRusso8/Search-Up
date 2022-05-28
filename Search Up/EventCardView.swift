//
//  EventCardView.swift
//  Search Up
//
//  Created by John Russo on 5/26/22.
//

import SwiftUI



struct EventCardView: View {
    
    @State var title: String
    @State var city: String
    @State var date: String
    @State var state: String
    @State var urlImage: String
    @State var id: Int
    @State var isFav = false
    
    var body: some View {
        NavigationLink(destination: EventDetails(title: title, city: city, state: state, date: formateDate(dateString: date), imageUrl: urlImage, id: id)) {
            Rectangle()
                        .frame(width: UIScreen.main.bounds.width - 10, height: 100)
                        .cornerRadius(20)
                        .foregroundColor(Color.white)
                        .shadow(radius: 10)
                        .overlay(
                            HStack {
                                ZStack{
                                    
                                    URLImage(urlString: urlImage)

                                        .frame(width: 50, height: 50)
                                        .foregroundColor(Color.cyan)
                                        .background(
                                            Rectangle()
                                                .foregroundColor(Color.yellow)
                                                .frame(width: 80, height: 80)
                                                .cornerRadius(20)
                                        )
                                        .padding(8)
                                    if(isFav){
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(Color.red)
                                            .offset(x: -35, y: -35)
                                    }
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(title)
                                        .bold()
                                        .font(.system(size: 14))
                                        .foregroundColor(.black)
                                    Text("\(city), \(state)")
                                        .font(.caption)
                                        .foregroundColor(Color.gray)
                                    Text(formateDate(dateString: date))
                                        .font(.caption)
                                        .foregroundColor(Color.gray)
                                }
                                .padding()
                                
                            }   .padding()
                                .frame(width: UIScreen.main.bounds.width - 10, height: 100, alignment: .leading)
                        )
        }.onAppear{
            isFav = isFav(id: id)
        }
    }
    
    func formateDate(dateString: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: date)
        
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date!)
        dateFormatter.dateFormat = "MMMM"
        var month = dateFormatter.string(from: date!)
        month = String(String(month).prefix(3))
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.string(from: date!)
        dateFormatter.dateFormat = "h:MM a"
        let time = dateFormatter.string(from: date!)

        var weekday = dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: date!) - 1]
        
        weekday = weekday.prefix(3).uppercased()
    
        return "\(weekday), \(day) \(month) \(year) \(time)"
    }
    
    func isFav(id: Int) -> Bool{
        let favoritesArray = UserDefaults.standard.array(forKey: "favorites") ?? []
        for fav in favoritesArray{
            if fav as! Int == id{
                return true
            }
        }
        return false
    }
}

struct EventCardView_Previews: PreviewProvider {
    static var previews: some View {
        EventCardView(title: "Title", city: "City", date: "2012-03-09T19:00:00", state: "State", urlImage: "https://seatgeek.com/images/performers-landscape/generic-minor-league-baseball-9c1f76/677210/35944/huge.jpg", id: 0)
    }
}
