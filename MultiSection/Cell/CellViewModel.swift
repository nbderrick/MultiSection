//
//  CellViewModel.swift
//  MultiSection
//
//  Created by Derrick Sun on 7/8/22.
//

import UIKit
import IGListKit

class CellViewModel: NSObject {
    private let identifier: String
    let storage: String
    
    init(name: String, data: String) {
        self.identifier = name
        self.storage = data
        super.init()
    }
}

extension CellViewModel: ListDiffable {
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? CellViewModel else {return false}
        if identifier == object.identifier && storage == object.storage {
            return true
        }
        return false
    }
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSObjectProtocol
    }
}
