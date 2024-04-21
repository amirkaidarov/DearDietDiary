//
//  DetailsViewModel.swift
//  DearDietDiary
//
//  Created by Амир Кайдаров on 4/20/24.
//

import Foundation

class DetailsViewModel : ObservableObject {
    let item : Item
    
    init(item: Item) {
        self.item = item
    }
}
