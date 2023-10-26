//
//  ImagePicker.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 02/10/2023.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
final class PhotoPicker: ObservableObject {
    @Published private(set) var selectedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else {return}
        
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                    return
                }
            }
        }
    }
}
