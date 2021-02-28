import SwiftUI

@main
struct GloryHubApp: App {

@State var currentStage = getUserFirstOpenView("user_accesstoken")
    
var body: some Scene {
    
    WindowGroup {
        
        if(self.currentStage == "OnboardingView"){
            OnboardingView(currentStage: $currentStage)
        } else if(self.currentStage == "LoginView"){
            LoginView(currentStage: $currentStage)
        } else if(self.currentStage == "SignupView"){
            SignupView(currentStage: $currentStage)
        } else {
            MainView()
        }
    }
  }
}

func getSavedString(_ index: String) -> String {
    var str = UserDefaults.standard.string(forKey: index) ?? ""
    //print("getSavedString: \(str)")
    return str
    //let str = UserDefaults.standard.object(forKey: index) as? String
    //return str == nil ? "" : str!
}

func getUserFirstOpenView(_ index: String) -> String {
    var str = UserDefaults.standard.string(forKey: index) ?? ""
    //print("getSavedString: \(str)")
    if(str != ""){
        str = "MainView"
    } else {
        str = "OnboardingView"
    }
    return str
    //let str = UserDefaults.standard.object(forKey: index) as? String
    //return str == nil ? "" : str!
}

