//
//  ContentView.swift
//  C2
//
//  Created by 이은지 on 4/19/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var quests: [Quest]

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
                            .overlay(Text("아카데미 튜토리얼").foregroundColor(.white))
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue)
                            .frame(width: 180, height: 120)
                            .overlay(Text("포스텍 시설 정복").foregroundColor(.white))
                    }
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.blue)
                        .frame(width: 370, height: 76)
                        .overlay(Text("학생 계정 툴 신청").foregroundColor(.white))
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
         // Preview용 임시(in-memory) 컨테이너 주입
         .modelContainer(for: Quest.self, inMemory: true)
 }
