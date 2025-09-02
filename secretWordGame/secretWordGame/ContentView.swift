//
//  ContentView.swift
//  secretWordGame
//
//  Created by ana on 01/09/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showLoginScreen = false
    
    var body: some View {
        VStack {
            Image(systemName: "gamecontroller")
                .imageScale(.large)
                .font(.system(size: 70))
                .frame(width: 0, height: 100)
                .foregroundStyle(.tint)
            Text("Secret Word")
                .font(.system(size:50))
                .padding()
                .font(.title)
                .background(Color.yellow)
                .cornerRadius(10)
            Button("PLAY") {
                showLoginScreen = true
            }
            .font(.system(size:60))
            .padding()
            .background(Color.red)
            .foregroundStyle(.white)
            .cornerRadius(10)
            .fontWeight(.bold)
        }
        .padding()
        .fullScreenCover(isPresented: $showLoginScreen) {
            SecretWordViewController()
        }
    }
}

#Preview {
    ContentView()
}
