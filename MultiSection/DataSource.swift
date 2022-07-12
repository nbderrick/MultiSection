//
//  DataSource.swift
//  MultiSection
//
//  Created by Derrick Sun on 7/8/22.
//

import UIKit
import IGListKit

class DataSource: NSObject {
    private var myData: [ListDiffable] = []
    private var delegate: CellDelegate?
    
    init(input: [ListDiffable]) {
        super.init()
        self.myData = input
    }
    override init() {
        super.init()
        self.myData = []
    }
    
    func getData() -> [ListDiffable] {
        return myData
    }
    func setData(array: [ListDiffable]) {
        myData = array
    }
    func setDelegate(delegate: ViewController) {
        self.delegate = delegate
    }
    func getDelegate() -> ViewController? {
        return delegate
    }
    
}

extension DataSource: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return myData
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if let obj = object as? SectionViewModel1 {
            let temp = SectionController1()
            if delegate != nil {
                temp.setDelegate(delegate: delegate!)
            }
            return temp
        } else {
            let temp = SectionController2()
            if delegate != nil {
                temp.setDelegate(delegate: delegate!)
            }
            return temp
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
