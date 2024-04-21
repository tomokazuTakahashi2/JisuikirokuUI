//
//  HomeCell.swift
//  JisuiKiroku
//
//  Created by 高橋智一 on 2024/04/21.
//

import SwiftUI

struct HomeCell: View {
    var imageName: String
    var date: String
    var title: String
    
    var body: some View {
        HStack {
            Image("img_noimage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 50)
                .background(Color.blue)
                .padding(.trailing, 10) // 画像の右側に余白を追加
            VStack(alignment: .leading) {
                Text(date)
                Text(title)
                    .font(.headline)
                
                HStack {
                    ForEach(0..<5) { index in
                        Button(action: {
                            // ボタンのアクション
                        }) {
                            Image(systemName: index < 3 ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }
            .padding(.leading, 10) // 右側のコンテンツに余白を追加
            .padding(.trailing, 10) // 右側のコンテンツに余白を追加
            
            Spacer() // コンテンツを右端に寄せる
        }
        .padding(10) // セル全体に余白を追加
        .background(Color.gray) // セルの背景色を指定
        .cornerRadius(10) // セルの角を丸める
    }
}
 
#Preview {
    HomeCell(imageName: "img_noimage", date: "2022/04/21", title: "タイトル")
        .previewLayout(.sizeThatFits)
        .padding()
}
