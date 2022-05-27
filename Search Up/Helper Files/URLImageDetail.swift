//
//  URLImageDetail.swift
//  Search Up
//
//  Created by John Russo on 5/26/22.
//

import SwiftUI

struct URLImageDetail: View {
    let urlString: String
    
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 400, height: 400)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        else{
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .onAppear {
                    fetchData()
                }
        }
    }

    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}
