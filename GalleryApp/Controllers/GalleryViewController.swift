//
//  GalleryViewController.swift
//  GalleryApp
//
//  Created by Nazar Dremach on 27/8/23.
//

import UIKit

class GalleryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func exit(_ sender: Any) {
        dismiss(animated: false)
    }

    @IBAction func addPhoto(_ sender: Any) {
        showPickingAlert()
        
    }
    private func showPickingAlert() {
        let alert = UIAlertController(title: "Add Photo", message: "Choose app for adding photo", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default)
        
        let galleryAction = UIAlertAction(title: "Camera", style: .default)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    }
}
