//
//  SearchBar.swift
//  Search Up
//
//  Created by John Russo on 5/26/22.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @StateObject var viewModel = ViewModel()
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.gray)
            
            TextField("Search...", text: $searchText)
                .foregroundColor(Color.white)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.gray)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture(perform: {
                            searchText = ""
                        })
                    
                    
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
        RoundedRectangle(cornerRadius:  25)
            .fill(Color.black)
            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 0)
        )
        .padding(.leading)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""))
    }
}
