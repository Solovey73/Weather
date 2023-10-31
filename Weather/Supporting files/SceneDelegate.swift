import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        window.makeKeyAndVisible()
        
        if (UserDefaults.standard.string(forKey: "mainCity") != nil) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            window.rootViewController = storyboard.instantiateViewController(withIdentifier: "secondVC") as? SecondVC
            
        } else {
            UserDefaults.standard.set(sities, forKey: "сities")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            window.rootViewController = storyboard.instantiateViewController(withIdentifier: "firstVC") as? FirstVC
        }
        
    }

}

