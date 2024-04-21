//
//  HomeView.swift
//  DearDietDiary
//
//  Created by Амир Кайдаров on 4/20/24.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @ObservedObject var homeVM : HomeViewModel
    
    init(user: User) {
        homeVM = HomeViewModel(user: user)
    }

    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottomTrailing) {
                VStack(spacing: -50){
                    VStack(alignment: .leading){
                        Spacer().frame(height: 50)
                        HomeNavBarView()
                            .padding(.bottom, 10)
                        Text("What's the purchase, chef?")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Text("Health score: \(Int(homeVM.score)) / 100")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        SearchBar(search: $homeVM.searchText)
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
                    
                    VStack{
                        SectionTitleView(title: "History")
                        
                        historyView
                            .shadow(color: Color.black.opacity(0.2),
                                    radius: 10,
                                    x: 0, y: 10)
                        
                    }.padding()
                    
                }
                
                NavigationLink {
                    SubmissionView()
                        .navigationBarHidden(true)
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 28, height: 28)
                        .padding()
                }
//                .background(Color(hex: 0x8559DC))
                .background(Color(hex: 0x4CAF50))
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding()
                
//                Button {
//                    showCameraView.toggle()
//                } label: {
//                    Image(systemName: "camera.viewfinder")
//                        .resizable()
//                        .renderingMode(.template)
//                        .frame(width: 28, height: 28)
//                        .padding()
//                }
//                .background(Color(hex: 0x8559DC))
//                .foregroundColor(.white)
//                .clipShape(Circle())
//                .padding()
//                .fullScreenCover(isPresented: $showCameraView) {
//                    SubmissionView()
//                }
            }
        }
    }

  
    private var historyView : some View {
        ScrollView {
            ForEach(homeVM.searchableItems) { item  in
                NavigationLink {
                    DetailsView(item: item)
                        .navigationBarHidden(true)
                } label: {
                    Group {
                        HStack (spacing : 16){
                            Text(item.name)
                                .font(.system(size: 20, weight: .semibold))
                            Spacer()
                            KFImage(URL(string: item.image))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20)
                                .padding(.horizontal)
                                .shadow(radius: 5)
                        }
                        .padding()

                    }
                    .padding(.leading)
                    .foregroundColor(Color(.label))
                    .background(Color.white)
                    .cornerRadius(18.0)

                }
            }
            .padding(.bottom, 50)
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}

struct HomeNavBarView: View {
    @State private var shouldShowLogoutOptions = false
    
    @EnvironmentObject var vm: AuthViewModel
    
    var body: some View {
        HStack (alignment: .center){
            Spacer()
            Button {
                shouldShowLogoutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color.white)
            }
        }
        .confirmationDialog(
            Text("Settings"),
            isPresented: $shouldShowLogoutOptions
        ) {
            Button("Exit", role: .destructive) {
                vm.signOut()
            }
            Button("Cancel", role: .cancel) {
                
            }
        } message: {
            Text("What do you want to do?")
        }

    }
}

struct SearchBar: View {
    @Binding var search : String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search for items", text: $search)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct SectionTitleView: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()
            
            Text("See All")
                .foregroundColor(Color("PrimaryColor"))
                .onTapGesture {
                    
                }
        }
        .padding(.vertical)
    }
}

