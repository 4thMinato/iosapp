//
//  EditPhotoView.swift
//  TenYear
//
//  Created by SHIH-YING PAN on 2019/10/16.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import SwiftUI

extension BlendMode {
    var name: String {
        return "\(self)"
    }
}

struct EditPhotoView: View {
    var level = ["初級","中級","高級"]
    

    @State private var selectBlend = BlendMode.screen
    @State private var brightnessAmount: Double = 0
    @State private var levelpicture = 0
    @State private var selectDate = Date()
    let today = Date()
    let startDate = Calendar.current.date(byAdding: .year, value: -2, to: Date())!
    var year: Int {
        Calendar.current.component(.year, from: selectDate)
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            NavigationView {
                VStack {
                    
                    ZStack {
                        Image(self.level[self.levelpicture])
                            .resizable()
                            .brightness(self.brightnessAmount)
                    }
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.width / 4 * 3)
                    .clipped()

                    Form {
                        BrightnessSlider(brightnessAmount: self.$brightnessAmount)
                        
                        DatePicker("時間", selection: self.$selectDate, in: self.startDate...self.today, displayedComponents: .date)
                        
                        Picker("選擇難度", selection: self.$levelpicture) {
                            ForEach(0 ..< self.level.count) {
                                Text(self.level[$0])
                            }
                        }
                    
                        
                    }
                    
                }
            }
            
        }
        
    }
}

struct EditPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        EditPhotoView()
    }
}

struct BrightnessSlider: View {
    
    @Binding var brightnessAmount: Double
    
    var body: some View {
        HStack {
            Text("亮度")
            Slider(value: self.$brightnessAmount, in: 0...1, minimumValueLabel: Image(systemName: "sun.max.fill").imageScale(.small), maximumValueLabel: Image(systemName: "sun.max.fill").imageScale(.large)) {
                Text("")
            }
        }
    }
}

/*struct TenYearImage: View {
    
    let width: CGFloat
    let selectDate: Date
    let brightnessAmount: Double
    var year: Int {
        return Calendar.current.component(.year, from: selectDate)
    }
    
    var body: some View {
        Image("jj\(self.year)")
            .resizable()
            .brightness(self.brightnessAmount)
    }
}*/
