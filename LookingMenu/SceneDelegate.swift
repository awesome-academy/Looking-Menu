import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        let windowScene = UIWindowScene(session: session, connectionOptions: connectionOptions)
        self.window = UIWindow(windowScene: windowScene)
        let status = UserDefaults.standard.bool(
            forKey: KeyUserDefaults.keyCheckNewUser)
        guard let mainVC = StoryBoardReference.main.storyBoard.instantiateViewController(
                identifier: IdStoryBoardViews.mainVC) as? ViewController,
              let welcomeVC = StoryBoardReference.main.storyBoard.instantiateViewController(
                identifier: IdStoryBoardViews.welcomeVC) as? WelcomeViewController
        else { return }
        let rootNC = UINavigationController(rootViewController: status ? mainVC : welcomeVC)
        self.window?.rootViewController = rootNC
        self.window?.makeKeyAndVisible()
    }
}
