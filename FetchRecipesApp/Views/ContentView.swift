//
//  ContentView.swift
//  FetchRecipesApp
//
//  Created by Sean Goldsborough on 4/14/25.
//

import SwiftUI
import SwiftData

struct Purchase: CustomStringConvertible {
    let id: Int
    let date: Date
    var description: String {
        return "Purchase #\(id) (\(date))"
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    let lists = ["James", "Steve", "Anna", "Baxter", "Greg", "Zendy", "Astro", "Jenny"]

    @ObservedObject var recipesListViewModel = RecipesListViewModel()
    

    func groupingFunc(recipies: [Recipe]) {
        let date1 = Calendar.current.date(from: DateComponents(year: 2010, month: 11, day: 22))!
        let date2 = Calendar.current.date(from: DateComponents(year: 2015, month: 5, day: 1))!
        let date3 = Calendar.current.date(from: DateComponents(year: 2012, month: 8, day: 15))!
        let purchases = [
            Purchase(id: 1, date: date1),
            Purchase(id: 2, date: date1),
            Purchase(id: 3, date: date2),
            Purchase(id: 4, date: date3),
            Purchase(id: 5, date: date3)
        ]
        
        let recipes = recipesListViewModel.recipes
        
        let groupingDictionary = Dictionary(grouping: recipes, by: { $0.cuisine })
        print("recipes", recipes, groupingDictionary)
        /*
         [
         2012-08-14 22:00:00 +0000: [Purchase #4 (2012-08-14 22:00:00 +0000), Purchase #5 (2012-08-14 22:00:00 +0000)],
         2010-11-21 23:00:00 +0000: [Purchase #1 (2010-11-21 23:00:00 +0000), Purchase #2 (2010-11-21 23:00:00 +0000)],
         2015-04-30 22:00:00 +0000: [Purchase #3 (2015-04-30 22:00:00 +0000)]
         ]
         */
        
        let groupingArray = Array(groupingDictionary.values)
        print(groupingArray)
        /*
         [
         [Purchase #3 (2015-04-30 22:00:00 +0000)],
         [Purchase #4 (2012-08-14 22:00:00 +0000), Purchase #5 (2012-08-14 22:00:00 +0000)],
         [Purchase #1 (2010-11-21 23:00:00 +0000), Purchase #2 (2010-11-21 23:00:00 +0000)]
         ]
         */
    }
    
//    var wordDict: [String:[Recipe]] {
////        let letters = Set(recipesListViewModel.recipes.compactMap( { $0.cuisine } ))
////        var dict: [String:[Recipe]] = [:]
////        //var sortedArray = letters.sorted { $0.cuisine < $1.cuisine }
////        for letter in sortedArray {
////            print("Letter: \(letters)")
////            //dict[String(letter)] = recipesListViewModel.recipes.filter( { $0.cuisine == letter } ).sorted()
////        }
//        
//        
//        let recipes = recipesListViewModel.recipes
//        let recipesByRegion = Dictionary(grouping: recipes, by: { $0.cuisine! })
//        
//        print("recipes: \(recipesByRegion)")
//        
//        return recipesByRegion
//    }

    var body: some View {
        NavigationSplitView {
            List {
                    // You then make an array of keys, sorted by lowest to highest
//                    ForEach(Array(wordDict.keys).sorted(by: <), id: \.self) { character in
//                        Section(header: Text("\(character)")) {
//                            // Because a dictionary lookup can return nil, we need to provide a response
//                            // if it fails. I used [""], though I could have just force unwrapped.
//                            ForEach(wordDict[character] ?? [""], id: \.self) { word in
//                                Text("Name \(word)")
//                            }
//                        }
//                    }
            }.onAppear {
                groupingFunc(recipies: recipesListViewModel.recipes)
            }
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
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
