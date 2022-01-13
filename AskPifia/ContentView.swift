//
//  ContentView.swift
//  AskPifia
//
//  Created by Svitlana Bublyk on 10/01/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var settings = false
    @State private var answerText = "Ask and shake me!"
    
    var body: some View {
        NavigationView {
            
            VStack {
                Text(answerText)
                    .onShake {
                        Api().getAnswer { answer in
                            answerText = answer.magic.answer
                        }
                    }
                    .padding(.horizontal)
                HStack {
                    Image(systemName: "arrow.clockwise")
                        .onTapGesture {
                            // update text onscreen
                        }
                        .padding()
                }
            }
            .navigationBarItems(trailing: Button(action: {
                self.settings = true
            }) {
                Image(systemName: "gearshape")
                    .foregroundColor(.gray)
            }
            )
        }
    }
}

// The notification we'll send when a shake gesture happens.
extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

//  Override the default behavior of shake gestures to send our notification instead.

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
    }
}


// A view modifier that detects shaking and calls a function of our choosing.
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



// A View extension to make the modifier easier to use.
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
