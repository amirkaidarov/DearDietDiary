//
//  HomeViewModel.swift
//  DearDietDiary
//
//  Created by Амир Кайдаров on 4/20/24.
//

import Foundation

class HomeViewModel : ObservableObject {
    @Published var items = [Item]()
    @Published var score = Float(0)
    @Published var searchText = ""
    let service = ItemService()
    
    
    init(user : User) {
        self.fetchScore(user: user)
        self.fetchItems(user: user)
    }
    
    private func fetchItems(user : User) {
        service.fetchItems(for: user.id!) { items in
            self.items = items
        }
    }
    
    private func fetchScore(user : User) {
        service.fetchScore(for: user.id!) { score in
            self.score = score
        }
    }
    
    var searchableItems : [Item] {
        print("here")
        if searchText.isEmpty {
            print("search text is empty")
            return items
        } else {
            print("search text is not empty")
            let searchQuery = searchText.lowercased()
            
            return items.filter { item in
                item.name.lowercased().contains(searchQuery)
            }
        }
    }
}
