import UIKit

final class WelcomeViewController: UIViewController {
    @IBOutlet private weak var iconLogo: UIImageView!
    @IBOutlet private weak var buttonStated: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configWelcomeView()
    }
    
    private func navigationMainView() {
        guard let mainVC = storyboard?.instantiateViewController(
                withIdentifier: IdStoryBoardViews.mainVC)
                as? ViewController else { return }
        UIApplication.shared.windows.first?.rootViewController = mainVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    private func configWelcomeView() {
        iconLogo.cornerCircle()
        navigationController?.setNavigationBarHidden(true, animated: true)
        buttonStated.cornerCircle()
    }
    
    @IBAction private func goMainView(_ sender: Any) {
        UserDefaults.standard.set(true,
                                  forKey: KeyUserDefaults.keyCheckNewUser)
        navigationMainView()
    }
}
