//
//  ContentView.swift
//  AskPifia
//
//  Created by Svitlana Bublyk on 10/01/2022.
//

import SwiftUI

/// Main view
struct ContentView: View {
    
   /// Button shows settings screen
    @State private var showSettings = false
    /// String shows answer
    @State private var answerText = "Ask and shake me!"
    /// Variable with default answers
    @ObservedObject var defaultAnswers = PossibleAnswers()
    
    var body: some View {
        NavigationView {
            
            VStack {
                Text(answerText)
                    .onShake {
                        updateAnsweredText(completion:{ answer in
                            answerText = answer
                        },defaultAnswers: defaultAnswers)
                    }
                    .padding(.horizontal)
                HStack {
                    Image(systemName: "arrow.clockwise")
                        .onTapGesture {
                            answerText = "Ask and shake me!"
                        }
                        .padding()
                }
            }
            .navigationBarItems(trailing: Button(action: {
                self.showSettings = true
            }) {
                Image(systemName: "gearshape")
                    .foregroundColor(.gray)
            }
            )
            .sheet(isPresented: $showSettings) {
                SettingsView(
                    possibleAnswer1: defaultAnswers.items[0].answerValue,
                    possibleAnswer2: defaultAnswers.items[1].answerValue,
                    possibleAnswer3: defaultAnswers.items[2].answerValue,
                    defaultAnswers: defaultAnswers
                )
            }
        }
    }
}

/// The notification we'll send when  shake gesture happens.
extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

///  Override the default behavior of shake gestures to send our notification instead.
extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
    }
}


/// A view modifier that detects shaking and calls a function of our choosing.
struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}



/// A View extension to make the modifier easier to use.
extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
