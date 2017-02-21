//
//  foods.swift
//  hw5
//
//  Created by Carlos Lemus on 2/21/17.
//  Copyright © 2017 Carlos Lemus. All rights reserved.
//

import Foundation
import UIKit

class Foods{
    let name: String
    let description: String
    
    
    init(name: String, description: String, iconName: String){
        self.name = name
        self.description = description
    }
    
    func foodImage() -> UIImage? {
        return UIImage(named: self.name)
    }
    
    func formatName() -> String? {
        return self.name.replacingOccurrences(of: "-", with: " ").capitalized
    }
}
