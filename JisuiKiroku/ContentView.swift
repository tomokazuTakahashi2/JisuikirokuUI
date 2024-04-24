//
//  ContentView.swift
//  JisuiKiroku
//
//  Created by 高橋智一 on 2024/04/19.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var isDetailViewPresented = false

    var body: some View {
        NavigationSplitView {
            ZStack(alignment: .bottomTrailing) {
                // リスト
                List {
                    ForEach(items) { item in
//                        NavigationLink {
                            HomeCell(imageName: item.itemImage,
                                     date: " \(formatDate(item.timestamp))",
                                     title: item.title)
//                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                // 新規投稿ボタン
                Button(action: {
                    // ボタンのアクション
                    isDetailViewPresented = true
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 20)) // アイコンのサイズを20に設定
                        .foregroundColor(.white) // アイコンの色を白色に設定
                        .frame(width: 60, height: 60) // ボタンのサイズを30x30に設定
                        .background(Color.blue) // ボタンの背景色を青色に設定
                        .cornerRadius(30) // ボタンを円形にするための角の半径を指定
                }
                .padding(.trailing, 30) // 右端から30ポイントの位置に配置
                .padding(.bottom, 30)
                NavigationLink(destination: DetailView(), isActive: $isDetailViewPresented) {
                    // ナビゲーションリンクを表示しないための空のビュー
                    EmptyView()
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy" // フォーマットに合わせて設定
        return dateFormatter.string(from: date)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
