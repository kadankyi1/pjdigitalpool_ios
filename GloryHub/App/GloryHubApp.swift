import SwiftUI

@main
struct GloryHubApp: App {

@State var currentStage = "OnboardingView"
var body: some Scene {
    WindowGroup {
        if (getSavedString("user_accesstoken") != "") {
            ContentView()
        } else {
                if(self.currentStage == "OnboardingView"){
                    OnboardingView(currentStage: $currentStage)
                } else if(self.currentStage == "LoginView"){
                    LoginView(currentStage: $currentStage)
                } else if(self.currentStage == "SignupView"){
                    SignupView(currentStage: $currentStage)
                } else if(self.currentStage == "LoggedInView"){
                    ContentView()
                }
        }
        
    }
  }
}

func getSavedString(_ index: String) -> String {
    let str = UserDefaults.standard.object(forKey: index) as? String
    return str == nil ? "" : str!
}

