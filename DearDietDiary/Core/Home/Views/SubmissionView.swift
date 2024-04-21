//
//  SubmissionView.swift
//  DearDietDiary
//
//  Created by Амир Кайдаров on 4/20/24.
//

import SwiftUI

struct SubmissionView: View {
    @ObservedObject var submissionViewModel = SubmissionViewModel()
    @EnvironmentObject var authViewModel : AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var showImagePicker = false
    @State private var selectedImage : UIImage?
    @State private var image : Image?
    @State private var name : String = ""
    @State var isActive: Bool = true
    
    
    var body: some View {
        NavigationStack {
            if self.isActive {
                ZStack (alignment: .bottomTrailing) {
                    VStack (spacing: -50) {
                        VStack(alignment: .leading){
                            Spacer().frame(height: 40)
                            HStack (alignment: .center){
                                Spacer()
                            }
                            Button(action: {
                                dismiss()
                            }) {
                                Label("Back", systemImage: "chevron.left")
                            }
                            .foregroundColor(.white)
                            .padding()
                            Text("New Item")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding(.horizontal)
                        }
                        .padding(10)
                        .background(LinearGradient(
                            gradient: Gradient(colors: [.green, .teal]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .background(
                            RoundedRectangle(cornerRadius:20)
                            
                                .shadow(color:Color.black.opacity(0.2),
                                        radius: 10,
                                        x: 0, y: 10))
                        .edgesIgnoringSafeArea(.top)
                        .padding(.bottom, 40)
                        
                        
                        CustomInputField (imageName : "fork.knife",
                                          placeholderText: "Food item",
                                          text : $name)
                        .padding()
                        
                        if let image = image {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)
                                .clipShape(Rectangle())
                                .padding()
                                .padding(.top, 70)
                        } else { Text("") }
                        
                        if let selectedImage = selectedImage {
                            if name != "" {
                                Button {
                                    withAnimation {
                                        self.isActive = false
                                    }
                                    submissionViewModel.sendImage(user: authViewModel.currentUser!,
                                                                  name: name,
                                                                  image: selectedImage) {
                                        DispatchQueue.main.async {
                                            withAnimation {
                                                self.isActive = true
                                            }
                                            dismiss()
                                        }
                                    }
                                } label: {
                                    Text("Submit")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(width: 340, height: 50)
                                        .background(Color(hex: 0x4CAF50))
                                        .clipShape(Capsule()
                                        )
                                }
                                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                                .padding(.top, 70)
                            }
                        }
                        Spacer()
                    }
                    
                    
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        Image(systemName: "camera.viewfinder")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 28, height: 28)
                            .padding()
                    }
                    .background(Color(hex: 0x4CAF50))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding()
                    .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: $selectedImage)
                    }
                }
            } else {
                ZStack {
                    Rectangle()
                        .background(Color.gray)
                        .opacity(0.4)
                    ProgressView("Loading")
                }
                .ignoresSafeArea()
            }
        }
    }
    
    func loadImage () {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
}

struct SubmissionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SubmissionView()
        }
    }
}
