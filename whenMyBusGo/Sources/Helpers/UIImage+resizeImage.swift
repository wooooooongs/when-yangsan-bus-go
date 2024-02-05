//
//  UIImage+resizeImage.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/6/24.
//

import UIKit

extension UIImage {
    convenience init?(originalImage: UIImage, width: Int, height: Int) {
        let newImageSize = CGSize(width: width, height: height)
        
        let renderer = UIGraphicsImageRenderer(size: newImageSize)
        let newImage = renderer.image { image in
            originalImage.draw(in: CGRect(origin: .zero, size: newImageSize))
        }
        
        guard let newCgImage = newImage.cgImage else {
            return nil
        }

        self.init(cgImage: newCgImage)
    }
    
    convenience init?(originalImage: UIImage, width newWidth: CGFloat) {
        let aspectRatio = originalImage.size.width / originalImage.size.height
        
        let newHeight: CGFloat = newWidth / aspectRatio
        let newImageSize = CGSize(width: newWidth, height: newHeight)
        
        let renderer = UIGraphicsImageRenderer(size: newImageSize)
        let newImage = renderer.image { image in
            originalImage.draw(in: CGRect(origin: .zero, size: newImageSize))
        }
        
        guard let newCGImage = newImage.cgImage else {
            return nil
        }
        
        self.init(cgImage: newCGImage)
    }
}
