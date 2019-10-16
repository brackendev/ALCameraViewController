//
//  ViewController.swift
//  ALCameraViewController
//
//  Created by Alex Littlejohn on 2015/06/17.
//  Copyright (c) 2015 zero. All rights reserved.
//
//  Modified by Kevin Kieffer on 2019/08/06.  Changes as follows:
//  Added an example aspect ratio for the crop rectangle.
//  Added a tap gesture on the displayed image to bring up the ConfirmViewController to recrop the image
//  If the camera is not available (ie. on simulator), pop up an error rather than crashing


import UIKit

class ViewController: UIViewController {

    
    let ASPECT_RATIO = 1.2  //Crop aspect ratio
    let MAX_ZOOM = 3.0    //Zoom in on image up to 3x
    
    var libraryEnabled: Bool = false
    var croppingEnabled: Bool = false
    var allowResizing: Bool = true
    var allowMoving: Bool = true
    var minimumSize: CGSize = CGSize(width: 60, height: 60)

    var croppingParameters: CroppingParameters {
        return CroppingParameters(isEnabled: croppingEnabled,
                                  allowResizing: allowResizing,
                                  allowMoving: allowMoving,
                                  minimumSize: minimumSize,
                                  aspectRatioHeightToWidth: CGFloat(ASPECT_RATIO),
                                  maximumZoom: CGFloat(MAX_ZOOM))
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var croppingParametersView: UIView!
    @IBOutlet weak var minimumSizeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.imageView.contentMode = .scaleAspectFit
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageTap)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {  //tapped on the member image
        
        if let image = imageView.image {
            
            let cropViewController = ConfirmViewController(image: image, croppingParameters: croppingParameters)
            
            cropViewController.onComplete = { [weak self] image, asset in
                if let image = image {
                    self?.imageView.image = image
                }
                self?.dismiss(animated: true, completion: nil)
            }
            cropViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            cropViewController.modalPresentationStyle = .fullScreen
            present(cropViewController, animated: true, completion: nil)
            
            
            
        }
    
    }
    
    
    @IBAction func openCamera(_ sender: Any) {
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alert = UIAlertController(title: "No camera available on this device",
                                            message: nil,
                                            preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              
            present(alert, animated: true)
            return
        }
        
        let cameraViewController = CameraViewController(croppingParameters: croppingParameters, allowsLibraryAccess: libraryEnabled) { [weak self] image, asset in
            if let image = image {
                self?.imageView.image = image
            }
            self?.dismiss(animated: true, completion: nil)
        }
        cameraViewController.modalPresentationStyle = .fullScreen

        present(cameraViewController, animated: true, completion: nil)
    }
    
    @IBAction func openLibrary(_ sender: Any) {
        let libraryViewController = CameraViewController.imagePickerViewController(croppingParameters: croppingParameters) { [weak self] image, asset in
            if let image = image {
                self?.imageView.image = image
            }
            self?.dismiss(animated: true, completion: nil)
        }
        libraryViewController.modalPresentationStyle = .fullScreen

        present(libraryViewController, animated: true, completion: nil)
    }
    
    @IBAction func libraryChanged(_ sender: Any) {
        libraryEnabled = !libraryEnabled
    }
    
    @IBAction func croppingChanged(_ sender: UISwitch) {
        croppingEnabled = sender.isOn
        croppingParametersView.isHidden = !sender.isOn
    }

    @IBAction func resizingChanged(_ sender: UISwitch) {
        allowResizing = sender.isOn
    }

    @IBAction func movingChanged(_ sender: UISwitch) {
        allowMoving = sender.isOn
    }

    @IBAction func minimumSizeChanged(_ sender: UISlider) {
        let newValue = sender.value
        minimumSize = CGSize(width: CGFloat(newValue), height: CGFloat(newValue))
        minimumSizeLabel.text = "Minimum size: \(newValue.rounded())"
    }
}

