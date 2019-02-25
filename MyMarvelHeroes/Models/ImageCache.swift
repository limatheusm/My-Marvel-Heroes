//
//  ImageCache.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 24/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation
import UIKit

class ImageCache: NSObject, NSDiscardableContent {
    
    public var image: UIImage
    
    init(_ image: UIImage) {
        self.image = image
    }
    
    func beginContentAccess() -> Bool {
        return true
    }
    
    func endContentAccess() {
        
    }
    
    func discardContentIfPossible() {
        
    }
    
    func isContentDiscarded() -> Bool {
        return false
    }
}
