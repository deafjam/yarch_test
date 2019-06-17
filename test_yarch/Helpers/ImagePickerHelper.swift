//
//  ImagePickerHelper.swift
//  test_mvvm
//
//  Created by Евгений Котовщиков on 12/06/2019.
//  Copyright © 2019 Евгений Котовщиков. All rights reserved.
//

import UIKit
import Photos

protocol ImagePickerProtocol: class {
  func imagePicked(image: UIImage)
}

class ImagePickerHelper: NSObject {
  
  weak var delegate: ImagePickerProtocol?
  
  func presentImagePickerController(in vc: UIViewController) {
    authorizeToPhotoLibrary { (authorized) in
      if authorized {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        vc.present(picker, animated: true)
      } else {
        let goToSettings = UIAlertAction(title: "Go to settings", style: .default) { (action) in
          let settingsUrl = URL(string: UIApplication.openSettingsURLString)!
          UIApplication.shared.open(settingsUrl)
        }
        let cancel = UIAlertAction(title: "cancel", style: .cancel)
        self.showAlert(in: vc, title: "photo lib unavailable", message: "enable access to library", actions: [goToSettings, cancel], style: .actionSheet, tintColor: .darkGray)
      }
    }
  }
  
  func presentCameraPickerController(in vc: UIViewController) {
    authorizeToCamera { (authorized) in
      if authorized {
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
          picker.delegate = self
          picker.sourceType = .camera
          picker.allowsEditing = true
          vc.present(picker, animated: true)
        }
      } else {
        let goToSettings = UIAlertAction(title: "Go to settings", style: .default) { (action) in
          let settingsUrl = URL(string: UIApplication.openSettingsURLString)!
          UIApplication.shared.open(settingsUrl)
        }
        let cancel = UIAlertAction(title: "cancel", style: .cancel)
        self.showAlert(in: vc, title: "camera lib unavailable", message: "enable access to camera", actions: [goToSettings, cancel], style: .actionSheet, tintColor: .darkGray)
      }
    }
  }
  
  
  private func authorizeToPhotoLibrary(completion: @escaping (Bool) -> Void ) {
    if PHPhotoLibrary.authorizationStatus() != .authorized {
      PHPhotoLibrary.requestAuthorization({ (status) in
        DispatchQueue.main.async(execute: {
          completion(status == .authorized)
        })
      })
    } else {
      completion(true)
    }
  }
  
  private func authorizeToCamera(completion: @escaping (Bool) -> Void ) {
    
    if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) != .authorized {
      AVCaptureDevice.requestAccess(for: .video) { (status) in
        DispatchQueue.main.async(execute: {
          completion(status == true)
        })
      }
    } else {
      completion(true)
    }
  }
  
  private func showAlert(in vc: UIViewController, title: String? = nil, message: String? = nil, actions: [UIAlertAction], style: UIAlertController.Style = .alert, tintColor: UIColor? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
    for action in actions {
      alertController.addAction(action)
    }
    if let tintColor = tintColor {
      alertController.view.tintColor = tintColor
    }
    vc.present(alertController, animated: true)
  }
}

extension ImagePickerHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
    picker.dismiss(animated: true) {
      self.delegate?.imagePicked(image: image)
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true)
  }
}

