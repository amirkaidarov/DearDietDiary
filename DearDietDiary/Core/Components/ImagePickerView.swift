//
//  ImagePickerView.swift
//  DearDietDiary
//
//  Created by Амир Кайдаров on 4/20/24.
//

import SwiftUI

struct ImagePicker : UIViewControllerRepresentable {
    @Binding var image : UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

extension ImagePicker {
    class Coordinator : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent : ImagePicker
        
        init(_ parent : ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            
            parent.image = image
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
