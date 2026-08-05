//
//  ListView.swift
//  C2
//
//  Created by 이은지 on 4/21/26.
//

import SwiftUI
import SwiftData

struct ListView: View {
    let pageTitle: String
    
    var body: some View {
        VStack(spacing: 35) {
            ScrollView {
                
            }
        }
        .navigationTitle(pageTitle)
        .padding()
        .background {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ListView(pageTitle: "리스트 페이지")
}
