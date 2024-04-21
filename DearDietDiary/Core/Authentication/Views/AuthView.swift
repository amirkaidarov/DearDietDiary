//
//  AuthView.swift
//  DearDietDiary
//
//  Created by Амир Кайдаров on 4/20/24.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        if viewModel.isLogin {
            LoginView()
                .navigationBarHidden(true)
        } else {
            RegistrationView()
                .navigationBarHidden(true)
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environmentObject(AuthViewModel())
    }
}
