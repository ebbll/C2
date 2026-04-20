//
//  ContentView.swift
//  C2
//
//  Created by 이은지 on 4/19/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            // Header
            HStack {
                Image(systemName: "star")
                Text("넵튠")
                    .font(.title)
                Spacer()
                Image(systemName: "tray")
            }
            .padding()
            // End of Header
            
            // Category Card
            VStack(alignment: .leading) {
                Text("러너를 위한 정보,자유롭게 탐험해보세요.")
                    .font(.title2)
                
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue)
                            .frame(width: 180, height: 120)
                            .overlay(Text("Item").foregroundColor(.white))
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue)
                            .frame(width: 180, height: 120)
                            .overlay(Text("Item").foregroundColor(.white))
                    }
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.blue)
                        .frame(width: 370, height: 76)
                        .overlay(Text("Item").foregroundColor(.white))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            // End of Category Card
            
            // Today's Recommended Card
            VStack(alignment: .leading, spacing: 10) {
                Text("📋  오늘 하기 좋은 일이에요")
                    .font(.title2)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(0..<10) { index in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.blue)
                                .frame(width: 250, height: 140)
                                .overlay(Text("Item \(index)").foregroundColor(.white))
                        }
                    }

                }
                .scrollTargetBehavior(.paging)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            // End of Today's Recommended Card
            
            // Reminder Card
            VStack(alignment: .leading) {
                Text("⏰  기한이 얼마 남지 않았어요")
                    .font(.title2)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(0..<10) { index in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.blue)
                                .frame(width: 250, height: 140)
                                .overlay(Text("Item \(index)").foregroundColor(.white))
                        }
                    }
                }
                .scrollTargetBehavior(.paging)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            // End of Reminder Card
        }
    }
}

#Preview {
    ContentView()
}
