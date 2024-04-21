//
//  AuthHeaderView.swift
//  DearDietDiary
//
//  Created by Амир Кайдаров on 4/20/24.
//

import SwiftUI

struct AuthHeaderView: View {
    var header : String = "What's up?"
    
    var body: some View {
        VStack (alignment: .center) {
            HStack{Spacer()}
            
            Text(header)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .frame(height: 260)
        .padding(.leading)
        .background(
            LinearGradient(
//                gradient: Gradient(colors: [.yellow, .pink, .purple, .blue]),
                gradient: Gradient(colors: [.green, .teal]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .foregroundColor(.white)
    }
}

struct AuthenticationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHeaderView()
    }
}
