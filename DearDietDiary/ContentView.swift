//
//  ContentView.swift
//  DearDietDiary
//
//  Created by Амир Кайдаров on 4/20/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var vm : AuthViewModel
    
    var body: some View {
        Group {
            if vm.userSession != nil {
//                mainInterfaceView
                if let user = vm.currentUser {
                    HomeView(user: user)
                        .navigationBarHidden(false)
                }
            } else {
                AuthView()
            }
            
        }
    }
}
//
//extension ContentView {
//    var mainInterfaceView : some View {
//        NavigationStack {
//            ZStack (alignment: .topLeading) {
//                if let user = vm.currentUser {
//                    HomeView(user: user)
//                        .navigationBarHidden(showMenu)
//                }
//
//                if showMenu {
//                    ZStack {
//                        Color(.black)
//                            .opacity(0.25)
//                    }.onTapGesture {
//                        withAnimation(.easeInOut) {
//                            showMenu.toggle()
//                        }
//                    }
//                    .ignoresSafeArea()
//                }
//
////                SideMenuView()
////                    .frame(width: 300)
////                    .background(showMenu ? Color.white : Color.clear)
////                    .offset(x: showMenu ? 0 : -300, y : 0)
//
//            }
//            .navigationTitle("LetitGo")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem (placement : .navigationBarLeading) {
//                    Button {
//                        withAnimation(.easeInOut) {
//                            showMenu.toggle()
//                        }
//                    } label: {
//                        Image(systemName: "square")
//                            .foregroundColor(.white)
//                    }
//                }
//            }
//            .onAppear() {
//                showMenu = false
//            }
//        }
//
//    }
//}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
