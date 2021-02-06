import SwiftUI

@main
struct GloryHubApp: App {

@State var currentStage = "OnboardingView"
var body: some Scene {
    WindowGroup {
            if(self.currentStage == "OnboardingView"){
                OnboardingView(currentStage: $currentStage)
            } else if(self.currentStage == "LoginView"){
                LoginView()
            }
    }
  }
}
