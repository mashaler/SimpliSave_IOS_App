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

        }

