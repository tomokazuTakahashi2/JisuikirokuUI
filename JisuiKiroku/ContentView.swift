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
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                        } label: {
                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
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
                    EmptyView() // ナビゲーションリンクを表示しないための空のビュー
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(itemImage: "img_noimage",
                               timestamp: Date(),
                               title: "タイトル")
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
