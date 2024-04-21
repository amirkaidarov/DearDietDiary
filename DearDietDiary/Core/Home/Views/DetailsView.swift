//
//  DetailsView.swift
//  DearDietDiary
//
//  Created by Амир Кайдаров on 4/20/24.
//

import SwiftUI
import Kingfisher

struct DetailsView: View {
    @ObservedObject var vm : DetailsViewModel
    @Environment(\.dismiss) var dismiss
    
    init(item : Item) {
        self.vm = DetailsViewModel(item: item)
    }
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            VStack(){
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
                    Text(vm.item.name)
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
                
                
                ScrollView {
                    Text("\(Int(vm.item.verdict.score)) / 100")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundStyle(.teal.gradient)
                        .padding(.top, 40)
                    
                    if vm.item.verdict.score > 60 {
                        SectionTitleView(title: "Verdict: Healthy")
                            .padding(.horizontal)
                    } else {
                        SectionTitleView(title: "Verdict: Unhealthy)")
                            .padding(.horizontal)
                    }
                    
//
//                    Divider()
//                        .padding(.horizontal)
//                        .padding(.top, 20)
                    
                    VStack{
                        SectionTitleView(title: "Summary")
                            .padding(.top, 20)
                        
                        summaryView
                            .shadow(color: Color.black.opacity(0.2),
                                    radius: 10,
                                    x: 0, y: 10)
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .frame(maxHeight: 400)
                    
//                    Divider()
//                        .padding(.horizontal)
//                        .padding(.top, 20)
                    
                    VStack{
                        SectionTitleView(title: "Nutrients")
                        
                        nutritionView
                            .shadow(color: Color.black.opacity(0.2),
                                    radius: 10,
                                    x: 0, y: 10)
                        
                    }
                    .padding()
                    .padding(.bottom, 80)
                    .frame(maxHeight: 700)
                    
                    //                    KFImage(URL(string: vm.item.image))
                    //                        .resizable()
                    //                        .frame(width: 200, height: 200)
                    //                        .aspectRatio(contentMode: .fit)
                    //                        .scaledToFit()
                    //                        .shadow(color: Color(red:0, green:0, blue:0, opacity:0.15), radius: 8, x: 6, y:8)
                    //                        .padding(.vertical, 20)
                    
                }
            }
        }
        .ignoresSafeArea()
    }
    
    
    
    private var nutritionView : some View {
        ScrollView {
            Group {
                HStack (spacing : 16){
                    Text("Calories")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Text("\(Int(vm.item.nutritionInfo.calories))")
                        .font(.system(size: 20, weight: .semibold))
                }
                .padding()
                
            }
            .padding(.leading)
            .foregroundColor(Color(.label))
            .background(Color.white)
            .overlay(
                Rectangle().frame(width: 10, alignment: .leading)
                    .foregroundColor(Color.green), alignment: .leading
            )
            .cornerRadius(18.0)
            
            ForEach(Array(vm.item.nutritionInfo.nutrients.keys.sorted()), id: \.self) { key in
                if let nutrient = vm.item.nutritionInfo.nutrients[key] {
                    Group {
                        HStack (spacing : 16){
                            Text(key)
                                .font(.system(size: 20, weight: .semibold))
                            Spacer()
                            Text(nutrient.value)
                                .font(.system(size: 20, weight: .semibold))
                        }
                        .padding()
                        
                    }
                    .padding(.leading)
                    .foregroundColor(Color(.label))
                    .background(Color.white)
                    .overlay(
                        Rectangle().frame(width: 10, alignment: .leading)
                            .foregroundColor(Color.green), alignment: .leading
                    )
                    .cornerRadius(18.0)
                }
            }
        }
    }
    
    private var summaryView : some View {
        
        ScrollView () {
            VStack (alignment: .leading, spacing: 8) {
                ForEach(Array(vm.item.verdict.explanation.keys.sorted()), id: \.self) { key in
                    if let explanation = vm.item.verdict.explanation[key] {
                        Text(explanation)
                            .font(.system(size: 20, weight: .semibold))
                    }
                }
            }
        }
        .padding()
        .padding(.leading, 8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color.white)
        .foregroundColor(Color(.label))
        .overlay(
            Rectangle().frame(width: 10, alignment: .leading)
                .foregroundColor(Color(hex: 0x013220)), alignment: .leading
        )
        .cornerRadius(18)
        
        //        ScrollView {
        //            ForEach(Array(vm.item.verdict.explanation.keys.sorted()), id: \.self) { key in
        //                if let explanation = vm.item.verdict.explanation[key] {
        //                    Group {
        //                        HStack (spacing : 5){
        //                            Spacer()
        //                            Text(explanation)
        //                                .font(.system(size: 20, weight: .semibold))
        //                            Spacer()
        //                        }
        //                        .padding()
        //
        //                    }
        //                    .padding(.leading)
        //                    .foregroundColor(Color(.label))
        //                    .background(Color.white)
        //                    .cornerRadius(18.0)
        //                }
        //            }
        //        }
    }
    
    //struct DetailsView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        NavigationStack {
    //            DetailsView(item: Item(name: "Milk", score: 50, image: "Russia"))
    //        }
    //    }
    //}
}
