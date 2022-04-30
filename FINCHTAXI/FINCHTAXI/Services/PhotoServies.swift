//
//  PhotoServies.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 25.02.2022.
//

import UIKit

protocol PhotoServiesInput {
    func saveImageInDocumentDirectory(image: UIImage, fileName: String) -> URL?
    func deleteImageFromDocumentDirectory(fileName: String)
    func loadImageFromDocumentDirectory(fileName: String) -> UIImage?
}

final class PhotoServies: PhotoServiesInput {
    
    // MARK: - Properties
    
    let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    
    // MARK: - Public methods
    
    func saveImageInDocumentDirectory(image: UIImage, fileName: String) -> URL? {
        guard let fileURL = documentsUrl?.appendingPathComponent(fileName) else {
            return nil
        }
        if let imageData = image.pngData() {
                try? imageData.write(to: fileURL, options: .atomic)
                return fileURL
            }
            return nil
        }
   
    func deleteImageFromDocumentDirectory(fileName: String) {
        guard let fileURL = documentsUrl?.appendingPathComponent(fileName) else {
            return
        }
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch {
                print("file deletion error")
            }
        }
    }
    
    func loadImageFromDocumentDirectory(fileName: String) -> UIImage? {
        guard let fileURL = documentsUrl?.appendingPathComponent(fileName) else {
            return nil
        }
            do {
                let imageData = try Data(contentsOf: fileURL)
                return UIImage(data: imageData)
            } catch {
                print("file saving error")
            }
            return nil
        }
    
}
