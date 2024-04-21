//
//  User.swift
//  DearDietDiary
//
//  Created by Амир Кайдаров on 4/20/24.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct User : Identifiable, Decodable {
    @DocumentID var id : String?
    let username : String
    let email : String
    let score: Float
    
    var isCurrentUser : Bool {
        return Auth.auth().currentUser?.uid == id
    }
}

