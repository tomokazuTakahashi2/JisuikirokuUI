//
//  DetailView.swift
//  JisuiKiroku
//
//  Created by 高橋智一 on 2024/04/21.
//

import SwiftUI
import SwiftData

/// 詳細画面
struct DetailView: View {
    @Environment(\.modelContext) private var context
    @Query private var items: [Item]
    @State private var recipeName = ""
    @State private var ingredients = [Ingredient]()
    @State private var directions = [String]()
    @State private var newIngredientName = ""
    @State private var newIngredientQuantity = ""
    @State private var newDirection = ""
    @State private var directionNumber = 1
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationView {
            VStack {
                
                List {
                    Section(header: Text("画像")) {
                        // 画像を表示するImageView
                        if let image = selectedImage {
                            GeometryReader { geometry in
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 200)
                                    .position(x: geometry.size.width / 2, y: 100)
                            }
                            .frame(height: 200)
                        } else {
                            GeometryReader { geometry in
                                ZStack {
                                    Image("img_noimage")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 200, height: 200)
                                        .background(Color.gray.opacity(0.2))
                                        .position(x: geometry.size.width / 2, y: 100)
                                    Button("画像を選択") {
                                        self.showingImagePicker = true
                                    }
                                }
                            }
                            .frame(height: 200)
                            .sheet(isPresented: $showingImagePicker) {
                                ImagePicker(selectedImage: self.$selectedImage)
                            }
                        }
                    }
                    Section(header: Text("レシピ名")) {
                        HStack {
                            TextField("レシピ名を入力", text: $recipeName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                                .onSubmit {
                                    if !recipeName.isEmpty {
                                        recipeName = recipeName
                                    }
                                }
                        }
                    }
                    Section(header: Text("材料")) {
                        ForEach(ingredients, id: \.name) { ingredient in
                            Text("\(ingredient.name) - \(ingredient.quantity)")
                        }
                    }
                    Section(header: Text("作り方")) {
                        ForEach(directions, id: \.self) { direction in
                            Text(direction)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                
                HStack {
                    TextField("材料名を入力", text: $newIngredientName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    TextField("個数を入力", text: $newIngredientQuantity)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding(.horizontal)
                    
                    Button(action: {
                        if !newIngredientName.isEmpty && !newIngredientQuantity.isEmpty {
                            let ingredient = Ingredient(name: newIngredientName, quantity: newIngredientQuantity)
                            ingredients.append(ingredient)
                            newIngredientName = ""
                            newIngredientQuantity = ""
                        }
                    }) {
                        Text("決定")
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                
                TextField("作り方を入力", text: $newDirection)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .onSubmit {
                        if !newDirection.isEmpty {
                            directions.append("\(directionNumber). \(newDirection)")
                            newDirection = ""
                            directionNumber += 1
                        }
                    }
                .padding()
                .background(Color.gray.opacity(0.2))
                
                Button("保存") {
                    add()
                }
                .foregroundColor(.white)
                .frame(width: 200, height: 20)
                .padding()
                .background(Color.blue)
                .cornerRadius(100)
            }
        }
    }
    
    private func add() {
        let data = Item(itemImage: selectedImage?.toString() ?? "img_noimage",
                        timestamp: Date(),
                        title: recipeName,
                        ingredients: ingredients,
                        directions: directions)
        context.insert(data)
    }
}

#Preview {
    DetailView()
}
