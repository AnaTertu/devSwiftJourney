
import SwiftUI

struct ContentView: View {
    
    @State private var showLoginScreen = false
    
    var body: some View {
        VStack {
            Image(systemName: "gamecontroller")
                .imageScale(.large)
                .font(.system(size: 80))
                .foregroundStyle(.tint)
            Text("Welcome Play Works!")
                .font(.system(size: 40))
            
            Button("Start") {
                showLoginScreen = true
            }
            .font(.system(size: 30))
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .fontWeight(.bold)
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
