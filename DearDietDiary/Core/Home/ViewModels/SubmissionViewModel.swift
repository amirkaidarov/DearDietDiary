//
//  SubmissionViewModel.swift
//  DearDietDiary
//
//  Created by Амир Кайдаров on 4/20/24.
//

import SwiftUI

class SubmissionViewModel : ObservableObject {
    let service = ItemService()
    
    func sendImage(user: User, name: String, image : UIImage, completion : @escaping() -> Void) {
        service.sendItem(name: name, image: image, user: user) { _, _ in
            completion()
        }
    }
}
