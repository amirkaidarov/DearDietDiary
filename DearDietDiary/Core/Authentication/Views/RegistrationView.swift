//
//  RegistrationView.swift
//  DearDietDiary
//
//  Created by Амир Кайдаров on 4/20/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email : String = ""
    @State private var username : String = ""
    @State private var password : String = ""
    
    @EnvironmentObject var vm : AuthViewModel
    
    var body: some View {
        VStack {
            
            AuthHeaderView()
            
            VStack (spacing: 40) {
                CustomInputField (imageName : "envelope",
                                  placeholderText: "Email",
                                  text : $email)
                CustomInputField (imageName : "person",
                                  placeholderText: "Username",
                                  text : $username)
                CustomInputField (imageName : "lock",
                                  placeholderText: "Password",
                                  isSecureField: true,
                                  text : $password)
            }
            .padding(32)
            
            
            Button {
                vm.register(email: email,
                            password: password,
                            username: username)
            } label: {
                Text("Sign up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
//                    .background(Color(hex: 0xB452B1))
                    .background(Color.green.gradient)
                    .clipShape(Capsule()
                    )
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            Button {
                vm.toggleIsLogin()
            } label: {
                HStack {
                    Text("Already have an account?")
                        .font(.footnote)
                    Text("Sign in")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
//            .foregroundColor(Color(hex: 0xB452B1))
            .foregroundColor(Color(hex: 0x4CAF50))
        }
        .ignoresSafeArea()
//        .navigationDestination(isPresented: $viewModel.didAuthenticateUser) {
//            ProfilePhotoSelectorView()
//        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
