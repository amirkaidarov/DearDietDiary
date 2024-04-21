//
//  Item.swift
//  DearDietDiary
//
//  Created by Амир Кайдаров on 4/20/24.
//

import Foundation


struct Item : Identifiable, Codable {
    var id = UUID()
    var name : String
    var image : String
    var verdict : Verdict
    var nutritionInfo : NutritionInfo
}

struct Verdict: Codable {
    var score: Float
    var explanation: [String: String]
}

struct NutritionInfo: Codable {
    var calories: Float
    var nutrients: [String: NutrientDetail]
}

struct NutrientDetail: Codable {
    var quantity: Float
    var unit: String
    var value: String
}
