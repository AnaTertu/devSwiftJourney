
import SwiftUI

struct ContentView: View {
    
    @State private var showLoginScreen = false
    
    var body: some View {
        VStack {
            Image(systemName: "gamecontroller")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Welcome Play Works!")
            
            Button("Start") {
                showLoginScreen = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .fullScreenCover(isPresented: $showLoginScreen) {
            ViewControllerWrapper()
        }
    }
}

#Preview {
    ContentView()
}
