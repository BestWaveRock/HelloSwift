//
//  ContentView.swift
//  HelloSwift
//
//  Created by 梁家新 on 2021/8/27.
//

import SwiftUI

struct ContentView: View {
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    @State var showScoreAlert = false
    @State var showChangeAlert = false
    
    /**
     * diff值只是三维空间中两点之间的距离 - 用户的错误。 要获得分数，请从1减去diff，然后将其缩放到100以外的值。较小的diff会产生较高的分数。
     * - Returns: 成绩
     */
    func computeScore() -> Int {
        let rDiff = rGuess - rTarget
        let gDiff = gGuess - gTarget
        let bDiff = bGuess - bTarget
        let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
        return Int((1.0 - diff) * 100.0 + 0.5)
    }
    
    var body: some View {
        VStack {
            HStack {
//                Text("Target Color Block").padding()
                VStack {
                    Rectangle().foregroundColor(Color(red: rTarget, green: gTarget, blue: bTarget))
                    Text("🎮匹配颜色🌈")
                }
//                Text("Guess Color Block").padding()
                VStack {
                    Rectangle().foregroundColor(Color(red: rGuess, green: gGuess, blue: bGuess, opacity: 1.0))
                    HStack {
                        Text("红: \(Int(rGuess * 255.0))")
                        Text("绿: \(Int(gGuess * 255.0))")
                        Text("蓝: \(Int(bGuess * 255.0))")
                    }
                }
            }
            
            HStack {
                VStack {
                    Button(action: {
                        self.showScoreAlert = true
                    }) {
                        Text("💻").padding()
                    }.alert(isPresented: $showScoreAlert) {
                        Alert(title: Text("💯"), message: Text("\(computeScore())"), dismissButton: .default(Text("👌")))
                    }
                }
                VStack {
                    Text("|")
                }.padding()
                VStack {
                    Button(action: {
                        self.rGuess = Double.random(in: 0..<1)
                        self.gGuess = Double.random(in: 0..<1)
                        self.bGuess = Double.random(in: 0..<1)
                        self.showChangeAlert = true
                    }, label: {
                        Text("👋").padding()
                    }).alert(isPresented: $showChangeAlert) { () -> Alert in
                        Alert(title: Text("更换😊成功"), dismissButton: .default(Text("👌")))
                    }
                }
            }
            
            VStack {
//                Text("Red slider")
//                Text("Green slider")
//                Text("Blue slider")
                
                // 色板控制器
                ColorSlider(value: $rGuess, textColor: .red)
                ColorSlider(value: $gGuess, textColor: .green)
                ColorSlider(value: $bGuess, textColor: .blue)
            }
        }
        
    }
}

#if DEBUG
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
//    }
//}
#endif 


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let contentView = ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

    
struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    var body: some View {
        HStack {
            Text("0").foregroundColor(textColor)
            Slider(value: $value)
            Text("255").foregroundColor(textColor)
        }.padding()
    }
}
