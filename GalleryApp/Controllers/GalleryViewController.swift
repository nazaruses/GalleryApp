//
//  GalleryViewController.swift
//  GalleryApp
//
//  Created by Nazar Dremach on 27/8/23.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }
    
    @IBAction func exit(_ sender: Any) {
//        dismiss(animated: false
        clearImages()
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        showPickingAlert()
        
    }
    private func showPickingAlert() {
        let alert = UIAlertController(title: "Add photo", message: "Choose app for adding photo", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.allowsEditing = false
            pickerController.mediaTypes = ["public.image"]
            pickerController.sourceType = .camera
            self?.present(pickerController, animated: true)
        }
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { [weak self] _ in
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.allowsEditing = false
            pickerController.mediaTypes = ["public.image"]
            pickerController.sourceType = .photoLibrary
            self?.present(pickerController, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    func saveImage(_ image: UIImage) {
        guard let saveDirectory = FileManager.default.urls(for:
                .documentDirectory, in:
                .userDomainMask).first, let imageData = image.pngData() else { return }
        
        let fileName = UUID().uuidString
        
        let fileURL = URL(fileURLWithPath: fileName, relativeTo:
                            saveDirectory).appendingPathExtension("png")
        
        try? imageData.write(to: fileURL)
        
        URLManager.addImagesName(fileName)
        
        loadImage(from: fileURL.absoluteURL)
        print ("File saved: \(fileURL.absoluteURL)")

    }
    func loadImage(from fileURL: URL) {
        guard let savedData = try? Data(contentsOf: fileURL), let image = UIImage(data: savedData) else { return }
        
        imageView.image = image
    }
    func loadImage() {
        guard let saveDirectory = FileManager.default.urls(for:
                .documentDirectory, in:
                .userDomainMask).first,
              let fileName = URLManager.getImagesNames().first
        else { return }
        
        
        let fileURL = URL(fileURLWithPath: fileName, relativeTo:
                            saveDirectory).appendingPathExtension("png")
        
        guard let savedData = try? Data(contentsOf: fileURL), let image = UIImage(data: savedData) else { return }
        
        imageView.image = image
        
    }
    func clearImages() {
        URLManager.deleteAll()
        imageView.image = nil
    }
}
    extension GalleryViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
        
        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
        
        public func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            guard let image = info[.originalImage] as? UIImage else {
                return
            }
            saveImage(image)
            picker.dismiss(animated: true)
        }
    }

