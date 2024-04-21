////
////  AlarmView.swift
////  DearDietDiary
////
////  Created by Амир Кайдаров on 4/20/24.
////
//
//import SwiftUI
//
//struct AlarmAddView : View {
//  @EnvironmentObject var alarmData: AlarmData
//  @Environment(\.isPresented) var isPresented: Binding<Bool>?
//
//  @State var date: Date = Date()
//
//  var body: some View {
//    NavigationView {
//        DatePicker($date, minimumDate: nil, maximumDate: nil, displayedComponents: .hourAndMinute)
//            .navigationBarTitle(Text("New Alarm"), displayMode: .inline)
//            .navigationBarItems(
//                leading: Button(action: self.cancel) { Text("Cancel") },
//                trailing: Button(action: self.createAlarm) { Text("Save") })
//    }
//  }
//
//  private func cancel() {
//    self.isPresented?.value = false
//  }
//
//  private func createAlarm() {
//    let newAlarm = Alarm(
//      date: date,
//      label: label,
//    )
//
//    self.alarmData.alarms.append(newAlarm)
//    self.isPresented?.value = false
//  }
//}
