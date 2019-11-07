//
//  game.swift
//  TenYear
//
//  Created by User19 on 2019/11/7.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import SwiftUI
import Foundation

struct game: View {
    
    @State private var money = 10000
    @State private var showAlert = false
    @State private var guessNumber = 0
    @State private var chip = 0
    @State private var times = 0;
    @State private var answer = Int.random(in: 0...100)
    
    //計算錢
    func num() -> Void {
        if self.guessNumber == self.answer {
           self.money += self.chip * 10
        }
        else if self.times == 5
        {
            self.money -= self.chip * 20
        }
    }
    
    var body: some View {
        NavigationView{
            VStack (alignment: .leading, spacing: 50){
                HStack(spacing:100){
                    Image("籌碼").resizable().frame(width: 50, height: 50)
                    Text(String(money))
                    .foregroundColor(.red)
                    .font(.largeTitle).fontWeight(.heavy)
                    Spacer()
                }
              ///......................................................
                TextField("請下注", value: $chip, formatter: NumberFormatter()) {
                   self.money -= self.chip
                }.textFieldStyle(RoundedBorderTextFieldStyle())
                 .padding()
              ///...................................................
              TextField("請猜一正整數", value: $guessNumber, formatter: NumberFormatter()) {
                 self.showAlert = true
                 self.times += 1
                 self.num()
              }.textFieldStyle(RoundedBorderTextFieldStyle())
               .padding()
             ///..................................................
                HStack(spacing:50){
                    Button(action: { self.answer = Int.random(in: 0...100);self.times = 0})
                    {
                        Image(systemName: "repeat")
                        Text("新的一局")
                    }
                  NavigationLink(destination: EditPhotoView())
                        {
                            Text("設定")
                        }
                }
              ///...................................................
                
          }
           .background(Image("background").resizable().frame(width: 500, height: 700)
          .opacity(0.8))
          .alert(isPresented: $showAlert) { () -> Alert in
             let result: String

             if self.guessNumber == self.answer {
                result = "你贏了"
                self.money += self.chip * 10
             }
             else if self.times == 5
             {
                 self.money -= self.chip * 20
                 result = "你輸了"
             }
             else if self.answer > self.guessNumber {
                result = "請猜多一點"
             } else {
                result = "請猜少一點"
             }
             return Alert(title: Text(result))
          }
        }
    }
}

struct game_Previews: PreviewProvider {
    static var previews: some View {
        game()
    }
}
