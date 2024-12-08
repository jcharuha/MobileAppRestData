//
//  Resturaunt.swift
//  Mobile Apps Project
//
//  Created by Joseh Charuhas on 10/24/24.
//

import UIKit
import Foundation

class Restauraunt
{
    var rName: String
    var rRating: Int
    var rAddress: String
    var rImage: String
    var rSignatureDish: String
    var rWebSite: String
    

    init(rName: String, rRating: Int, rAddress: String, rImage: String, rSignatureDish: String, rWebSite: String)
    {
        self.rName = rName
        self.rRating = rRating
        self.rAddress = rAddress
        self.rImage = rImage
        self.rSignatureDish = rSignatureDish
        self.rWebSite = rWebSite
    }
    
    init()
    {
        self.rName = ""
        self.rRating = 0
        self.rAddress = ""
        self.rImage = ""
        self.rSignatureDish = ""
        self.rWebSite = ""
    }
}
