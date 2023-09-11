import UIKit
import ChatSDK
import MessagingSDK
import Lottie

class HelpVC: UIViewController {
    @IBOutlet weak var chatButton: UIButton!
    
    private var lottieanimationView: LottieAnimationView!

    @IBAction func buttonPressed(_ sender: AnyObject) {
        do {
            let chatEngine = try ChatEngine.engine()
            let viewController = try Messaging.instance.buildUI(engines: [chatEngine], configs: [])

            self.navigationController?.pushViewController(viewController, animated: true)
        } catch {
            // Handle error
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //setupAnimation()
    }

//    func setupAnimation() {
//        lottieanimationView = .init(name: "ChatBot")
//        lottieanimationView.frame = view.frame
//        lottieanimationView.contentMode = .scaleAspectFit
//        lottieanimationView.loopMode = .loop
//        lottieanimationView.animationSpeed = 1.0
//        view.addSubview(lottieanimationView)

        // Start playing the animation
        //lottieanimationView.play { [weak self] _ in
            // Animation has finished playing, now add the chat interface
          //  self?.addChatInterface()
        }

//    func addChatInterface() {
//        do {
//            let chatEngine = try ChatEngine.engine()
//            let viewController = try Messaging.instance.buildUI(engines: [chatEngine], configs: [])
//
//            self.navigationController?.pushViewController(viewController, animated: true)
//        } catch {
//            // Handle error
//        }
//    }
//}
