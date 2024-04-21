//
//  DetailView.swift
//  JisuiKiroku
//
//  Created by 高橋智一 on 2024/04/21.
//

import SwiftUI

struct DetailView: View {
    @State private var ingredients = ""
    @State private var directions = ""
    
    var body: some View {
        VStack {
            TextField("材料を入力", text: $ingredients)
                .padding()
                .border(Color.gray)
                .padding(.horizontal)
            
            TextField("作り方を入力", text: $directions)
                .padding()
                .border(Color.gray)
                .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Recipe Detail")
        .padding(.bottom, 50) // キーボードが表示されたときにビューが隠れないようにするための余白
    }
}
