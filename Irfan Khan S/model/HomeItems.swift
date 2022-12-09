//
//  HomeItems.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 06/12/22.
//

import Foundation
import UIKit

class HomeItems {
  
  var id: Int
  var name: String
  var image: UIImage

  init(idValue: Int, nameValue: String, imageValue: UIImage){
    self.id = idValue
    self.name = nameValue
    self.image = imageValue
  }

}
