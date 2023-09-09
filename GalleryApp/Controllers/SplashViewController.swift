//
//  ViewController.swift
//  GalleryApp
//
//  Created by Nazar Dremach on 20/8/23.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    @IBOutlet weak var animationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.animationView.pause()
            
            let destinationViewControler = LoginViewController()
            destinationViewControler.modalPresentationStyle = .fullScreen
            self?.present(destinationViewControler, animated: false)
            
            
        }
        
        
    }
    
}
