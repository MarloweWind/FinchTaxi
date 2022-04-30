//
//  ImagePicker.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 24.02.2022.
//

import UIKit

public protocol ImagePickerDelegate: AnyObject {
    func didSelect(image: UIImage?)
}

final class ImagePicker: NSObject, UINavigationControllerDelegate {
    
    // MARK: - Locals

    private enum Locals {
        static let takePhotoText = "Сделать фото"
        static let userPhotoText = "Ваши фотографии"
        static let cancelText = "Отменить"
    }

    
    // MARK: - Properties
    
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    private let pickerController: UIImagePickerController
    
    
    // MARK: - Init

    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()

        super.init()

        self.presentationController = presentationController
        self.delegate = delegate
    
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }
    
    
    // MARK: - Public methods
    
    public func present(from sourceView: UIView) {

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: Locals.takePhotoText) {
            alertController.addAction(action)
        }
        
        if let action = self.action(for: .photoLibrary, title: Locals.userPhotoText) {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: Locals.cancelText, style: .cancel, handler: nil))

        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }

        self.presentationController?.present(alertController, animated: true)
    }
    
    
    // MARK: - Private methods
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        
        self.delegate?.didSelect(image: image)
    }
    
}


// MARK: - UIImagePickerControllerDelegate
extension ImagePicker: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
    
}
