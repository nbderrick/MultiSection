//
//  SectionController1.swift
//  MultiSection
//
//  Created by Derrick Sun on 7/8/22.
//

import UIKit
import IGListKit

final class SectionController1: ListBindingSectionController<ListDiffable>, ListBindingSectionControllerDataSource {
    private var delegate: CellDelegate?
    
    override init() {
        super.init()
        self.minimumLineSpacing = 1
        self.supplementaryViewSource = self
        self.dataSource = self
    }

    func setDelegate(delegate: CellDelegate) {
        self.delegate = delegate
    }
    
    override func numberOfItems() -> Int {
        return self.viewModels.count
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
        if let object = object as? SectionViewModel1 {
            return object.getStorage()
        } else if let object = object as? SectionViewModel2 {
            return object.getStorage()
        }
        else {fatalError()}
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else {fatalError()}
        
        let height: CGFloat = 40
        return CGSize(width:width, height: height)
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell & ListBindable {
        guard let cell = collectionContext?.dequeueReusableCell(of: CustomCell.self, for: self, at: index)
        else {fatalError()}
        
        guard let cell = cell as? CustomCell else {fatalError()}
        if delegate != nil {
            cell.delegate = delegate
        }
        cell.backgroundColor = .red
        return cell
    }
}

extension SectionController1: ListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            return userHeaderView(atIndex: index)
        default:
            fatalError()
        }
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionContext!.containerSize.width, height: 40)
        }
        else {
            return .zero
        }
    }
    
    private func userHeaderView(atIndex index: Int) -> UICollectionReusableView {
        let view: HeaderView = collectionContext?.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader, for: self, class: HeaderView.self, at: index) as! HeaderView
            return view
    }
}
