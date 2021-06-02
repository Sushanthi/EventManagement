//
//  ImageExtension.swift
//  EventManagement
//
//  Created by ur268042 on 5/29/21.
//

import UIKit

extension UIImageView {
    func loadImageFromURL(url: String) {
        guard let url = URL(string: url) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func makeRoundCorners(byRadius rad: CGFloat) {
         self.layer.cornerRadius = rad
         self.clipsToBounds = true
      }
    
}
