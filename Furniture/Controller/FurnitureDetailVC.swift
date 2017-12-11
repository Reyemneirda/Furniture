//
//  FurnitureDetailVC.swift
//  Furniture
//
//  Created by ronny abraham on 12/10/17.
//  Copyright © 2017 ronny abraham. All rights reserved.
//

import UIKit

class FurnitureDetailVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var furniture: Furniture?
    
    @IBOutlet weak var choosePhotoButton: UIButton!
    @IBOutlet weak var furnitureTitleLabel: UILabel!
    @IBOutlet weak var furnitureDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
        // Do any additional setup after loading the view.
    }

    func updateView() {
        guard let furniture = furniture else {return}
        if let imageData = furniture.imageData,
            let image = UIImage(data: imageData) {
            choosePhotoButton.setTitle("", for: .normal)
            choosePhotoButton.setImage(image, for: .normal)
        } else {
            choosePhotoButton.setTitle("Choose Image", for: .normal)
            choosePhotoButton.setImage(nil, for: .normal)
        }
        
        furnitureTitleLabel.text = furniture.name
        furnitureDescriptionLabel.text = furniture.description
        
    }
    
    @IBAction func choosePhotoButtonTapped(_ sender: Any) {
        
        let picker: UIImagePickerController = UIImagePickerController ()
        picker.delegate = self
        
        let alertController: UIAlertController = UIAlertController(title: "", message: "Choose An Action", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
            print("User Select Camera")
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
            
        })
        alertController.addAction(cameraAction)
            
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
        let libraryAction = UIAlertAction(title: "Choose From Library", style: .default, handler: { action in
            print("User Select Camera")
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
            
        })
        
        alertController.addAction(libraryAction)
        }
        
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            else {return}
        self.furniture?.imageData = UIImagePNGRepresentation(selectedImage)
        
        self.updateView()
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func actionButtonTapped(_ sender: Any)
    {
        guard let image = self.choosePhotoButton.imageView else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender as? UIView
        
        present(activityController, animated: true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
