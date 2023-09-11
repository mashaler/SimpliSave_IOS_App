//
//  LaunchScreenVC.swift
//  SimpliSave
//
//  Created by DA MAC M1 126 on 2023/07/19.
//

import UIKit
import Lottie

class LaunchScreenVC: UIViewController {
    private var lottieanimationView: LottieAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAnimation()
        
    }
    
    func setupAnimation() {
        lottieanimationView = .init(name: "load")
        lottieanimationView.frame = view.frame
        lottieanimationView.contentMode = .scaleAspectFit
        lottieanimationView.loopMode = .loop
        lottieanimationView.animationSpeed = 1.0
        view.addSubview(lottieanimationView)
        lottieanimationView.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                 self.navigate()
             }
        
    }

    
    func navigate() {
        if let view2Controller = storyboard?.instantiateViewController(withIdentifier: "Landing") {
            navigationController?.pushViewController(view2Controller, animated: true)
        }
    }

}

