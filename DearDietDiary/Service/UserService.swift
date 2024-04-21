//
//  UserService.swift
//  DearDietDiary
//
//  Created by Амир Кайдаров on 4/20/24.
//


import Foundation
import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchUser(with uid : String, completion : @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, error in
                guard let snapshot = snapshot else { return }
                guard let user  = try? snapshot.data(as: User.self) else { return }
                
                completion(user)
            }
    }
}

