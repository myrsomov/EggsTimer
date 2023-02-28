//
//  ContentView.swift
//  EggsTimer
//
//  Created by Myroslav Somov on 18/2/23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var value = 0
    let soft = 180
    let medium = 300
    let hard = 480
    @State private var timer: Timer?
    @State private var player: AVAudioPlayer!
    
    func convertSecondsToTime(timeInSeconds: Int) -> String {
        let minutes = timeInSeconds / 60
        let seconds = timeInSeconds % 60
        
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    
    var body: some View {
        
        ZStack {
            Color(.systemGray4)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(alignment: .center) {
                
                Spacer()
                
                Text("How do you like eggs?\n Press Soft, Medium or Hard")
                    .foregroundColor(Color("adaptive"))
                    .font(.title2)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding()

                HStack(alignment: .center, spacing: 40.0) {
                    
                    VStack{
                        Image("soft_egg")
                            .resizable()
                            .frame(width: 50, height: 70)
                        Button {
                            value = soft
                        } label: {
                            Text("Soft")
                                .font(.headline)
                               
                        }
                    }
                    .padding()
                    VStack{
                        Image("medium_egg")
                            .resizable()
                            .frame(width: 50, height: 70)
                          
                        Button {
                            value = medium
                        } label: {
                            Text("Medium")
                                .font(.headline)
                               
                        }
                    }
                    .padding()
                    VStack{
                        Image("hard_egg")
                            .resizable()
                            .frame(width: 50, height: 70)
                        Button {
                            value = hard
                        } label: {
                            Text("Hard")
                                .font(.headline)
                        }
                    }
                    .padding()

                }
                .font(.title)
                .foregroundColor(Color("adaptive"))
                .background(Color(.gray).opacity(0.7))
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
           
                .padding()
                
                Button {
                    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { time in
                        if value > 0 {
                            value -= 1
                        } else {
                            timer?.invalidate()
                            
                            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                            player = try! AVAudioPlayer(contentsOf: url!)
                            player.play()
                            
                            
                        }
                    }
                } label: {
                    Label("START!", systemImage: "stopwatch")
                        .font(.headline)
                      
                }
                .foregroundColor(Color("adaptive"))
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle(radius: 12))
                .tint(.orange)
                
                Text(convertSecondsToTime(timeInSeconds: value))
                    .padding()
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                Spacer()
                
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
