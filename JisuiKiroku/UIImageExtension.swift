//
//  UIImageExtension.swift
//  JisuiKiroku
//
//  Created by 高橋智一 on 2024/04/22.
//

import UIKit

extension UIImage {
    func toString() -> String? {
        guard let imageData = self.jpegData(compressionQuality: 1.0) else {
            return nil
        }
        return imageData.base64EncodedString()
    }
}
