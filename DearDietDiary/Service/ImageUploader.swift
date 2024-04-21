//
//  ImageUploader.swift
//  DearDietDiary
//
//  Created by Амир Кайдаров on 4/20/24.
//


import UIKit
import Firebase
import FirebaseStorage

struct ImageUploader {
    static func uploadImage(_ imageData : Data, completion : @escaping(String) -> Void) {
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(filename)")
        ref.putData(imageData) { _, error in
            if let error = error {
                print("Failed to upload image : \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { imageUrl, error in
                
                if let error = error {
                    print("Failed to download image : \(error.localizedDescription)")
                    return
                }
                
                guard let imageUrl = imageUrl?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
}
