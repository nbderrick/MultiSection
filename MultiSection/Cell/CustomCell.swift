//
//  CustomCell.swift
//  MultiSection
//
//  Created by Derrick Sun on 7/8/22.
//

import UIKit
import IGListKit

class CustomCell: UICollectionViewCell {
    var delegate: CellDelegate?
    var text:UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.numberOfLines = 1
        temp.lineBreakMode = .byTruncatingTail
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(text)
        text.text = ""
        text.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        text.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        text.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.backgroundColor = .white
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomCell: ListBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? CellViewModel else {return}
        text.text = viewModel.storage
    }
}

protocol CellDelegate: ViewController {
    func searchTerm() -> String
}
