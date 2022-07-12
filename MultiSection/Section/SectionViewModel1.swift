//
//  SectionViewModel1.swift
//  MultiSection
//
//  Created by Derrick Sun on 7/8/22.
//

import UIKit
import IGListKit

class SectionViewModel1: NSObject{
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
extension SectionViewModel1: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return "container1" as NSObjectProtocol
    }
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? SectionViewModel1 else {return false}
        if object == self {
            return true
        }
        return false
    }
}
