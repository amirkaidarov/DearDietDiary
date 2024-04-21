//
//  ItemService.swift
//  DearDietDiary
//
//  Created by Амир Кайдаров on 4/20/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ItemService: ObservableObject {
    
    func sendItem(name : String, image : UIImage, user : User, completion: @escaping (Bool, Error?) -> Void) {
        print("sending my message...")
        
        guard let imageData = image.jpegData(compressionQuality: 0.9) else { return }
        
        guard let url = URL(string: "https://9266-96-245-86-149.ngrok-free.app/file") else {
            completion(false, nil)
            return
        }
        
        // Create the URLRequest object
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Define the content type in the HTTP headers
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Create the body of the request
        var body = Data()
        
        // Append the image data to the body
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Set the body on the request
        request.httpBody = body
        
        var imageURL = ""
        
        // Use URLSession to send the request
        ImageUploader.uploadImage(imageData) { imageurl in
            imageURL = imageurl
            print("here: image uploaded")
            
            DispatchQueue.main.async {
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    
                    guard let data = data, error == nil else {
                        print(error?.localizedDescription ?? "No data")
                        return
                    }
                    
                    let rawJSONString = String(data: data, encoding: .utf8) ?? "Invalid JSON Data"
                    print("Received JSON: \(rawJSONString)")
                    
                    if let tempItem = try? JSONDecoder().decode(TempItem.self, from: data) {
                        print("here: tempItem done")
                        let newItem = Item(
                            name: name,
                            image: imageURL,
                            verdict: tempItem.verdict,
                            nutritionInfo: tempItem.nutritionInfo
                        )
                        self.sendToFirebase(user: user, newItem: newItem) {
                            DispatchQueue.main.async {
                                self.updateUserScore(user: user, newItem: newItem) {
                                    completion(true, nil)
                                }
                            }
                        }
                    } else {
                        print("Failed to decode the received data")
                        completion(false, nil)
                    }
                    
                }
                task.resume()
            }
            
        }
        
        //            if let responseJSON = responseJSON as? [String: Any] {
        //                print("-----2> responseJSON: \(responseJSON["text"]!)")
        //                if let nutritionInfo = responseJSON["nutrition_info"] as? [String : Any] {
        //                    let calories = nutritionInfo["calories"] as? Float
        //                    if let nutrients = nutritionInfo["nutrients"] as [String : Any] {
        //
        //                    }
        //                }
        //
        //                if let verdict = responseJSON["verdict"] as? [String : Any] {
        //                    let description = verdict["explanation"] as? [String : String]
        //                    let score = verdict["score"] as? Float
        //                    var imageURL = self.uploadImage(user: user, imageData: imageData)
        //                    self.sendToFirebase(user: user, name: name, score: score ?? 52, imageURL: imageURL, nutritionalValue: nutritionalValue ?? [String : Int]())
        //                    print("sending response...")
        //                }
        //            }
    }
    
    private func sendToFirebase(user: User, newItem : Item, completion : @escaping() -> Void){
        print("here")
        do {
            // Create a new document in Firestore with the newMessage variable above, and use setData(from:) to convert the Message into Firestore data
            // Note that setData(from:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
            try Firestore.firestore()
                .collection("users")
                .document(user.id!)
                .collection("items")
                .document().setData(from: newItem) { _ in
                    completion()
                }
            
        } catch {
            // If we run into an error, print the error in the console
            print("Error adding message to Firestore: \(error)")
        }
    }
    
    private func updateUserScore(user: User, newItem : Item, completion : @escaping() -> Void){
        // Create a new document in Firestore with the newMessage variable above, and use setData(from:) to convert the Message into Firestore data
        // Note that setData(from:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
        let db = Firestore.firestore()
        
        // Reference to the specific document from which to fetch the current score
        let scoreDocumentRef = db.collection("users").document(user.id!)
        
        // Reference to the collection for counting documents
        let collectionRef = scoreDocumentRef.collection("items")
        
        // Fetch the current score from the document
        scoreDocumentRef.getDocument { (document, error) in
            if let document = document, document.exists, let oldScore = document.data()?["score"] as? Float {
                // Fetch the number of items in the collection
                collectionRef.getDocuments { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else if let querySnapshot = querySnapshot {
                        // Calculate the new score
                        let lenItems = Float(querySnapshot.documents.count)
                        let updatedScore = (oldScore * (lenItems - 1) + newItem.verdict.score) / (lenItems)
                        
                        // Update the document with the new score
                        scoreDocumentRef.updateData([
                            "score": updatedScore
                        ]) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            } else {
                                print("Document successfully updated with new score: \(updatedScore)")
                            }
                            completion()
                        }
                    }
                }
            } else {
                print("Document does not exist or score field is missing")
            }
        }
    }
    
    func fetchItems(for uid : String, completion : @escaping([Item]) -> Void) {
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("items")
            .addSnapshotListener({ collectionSnapshot, _ in
                guard let documents = collectionSnapshot?.documents else { return }
                let items = documents.compactMap({ try? $0.data(as: Item.self)})
                
                completion(items)
            })
    }
    
    func fetchScore(for uid : String, completion : @escaping(Float) -> Void) {
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .addSnapshotListener({ documentSnapshot, error in
                guard let snapshot = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = snapshot.data() else {
                    print("Document data was empty.")
                    return
                }
                print("Current data: \(data)")
                // If you want to react to a specific field change:
                if let specificFieldValue = data["score"] as? Float {
                    print("Specific field value: \(specificFieldValue)")
                    completion(specificFieldValue)
                }
            })
    }
}

extension String: CustomNSError {
    
    public var errorUserInfo: [String : Any] {
        [
            NSLocalizedDescriptionKey: self
        ]
    }
}

struct TempItem: Codable {
    var nutritionInfo: NutritionInfo
    var verdict: Verdict
}
