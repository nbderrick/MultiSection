//
//  SectionViewModel2.swift
//  MultiSection
//
//  Created by Derrick Sun on 7/11/22.
//

import UIKit
import IGListKit

class SectionViewModel2: NSObject {
    private let storage: [CellViewModel]
    
    override init() {
        storage = []
        super.init()
    }
    
    required init(array: [CellViewModel]) {
        storage = array
        super.init()
    }
    
    func getStorage() -> [CellViewModel] {
        return storage
    }
}
extension SectionViewModel2: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return "container2" as NSObjectProtocol
    }
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? SectionViewModel2 else {return false}
        if object == self {
            return true
        }
        return false
    }
}
