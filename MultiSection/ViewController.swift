//
//  ViewController.swift
//  MultiSection
//
//  Created by Derrick Sun on 7/8/22.
//

import UIKit
import IGListKit

class ViewController: UIViewController {
    private var myTextField: UITextField = {
        var result = UITextField()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.backgroundColor = .lightGray
        result.placeholder = "type here!"
        result.enablesReturnKeyAutomatically = true
        result.keyboardType = .default
        result.returnKeyType = .go
        result.borderStyle = UITextField.BorderStyle.roundedRect
        return result
    }()
    var dataSource: DataSource = {
        var source = DataSource()
        return source
    }()
    private var myCollectionView: UICollectionView = {
        var layout: ListCollectionViewLayout = {
            var result = ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: false)
            return result
        }()
        let CV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        CV.backgroundColor = .white
        CV.translatesAutoresizingMaskIntoConstraints = false
        return CV
    }()
    lazy var adapter: ListAdapter = {
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: self, workingRangeSize: 0)
        return adapter
    }()
    var search:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var array: [CellViewModel] = []
        for i in 1...20 {
            let temp = CellViewModel(name: String(i), data: String(i))
            array.append(temp)
        }
        
        var newarray:[CellViewModel] = []
        for i in 1...20 {
            let temp = CellViewModel(name: String(i), data: String(i))
            newarray.append(temp)
        }
        dataSource.setData(array: [SectionViewModel1(array: array),SectionViewModel2(array: newarray)])
        
        view.addSubview(myTextField)
        myTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        myTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        myTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        myTextField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        myTextField.delegate = self
        myTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        dataSource.setDelegate(delegate: self)
        
        view.addSubview(myCollectionView)
        myCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        myCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        myCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        myCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        adapter.dataSource = self.dataSource
        adapter.collectionView = self.myCollectionView
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        search = textField.text ?? ""
        var data = dataSource.getData()
        var array: [CellViewModel] = []
        if let obj = data[1] as? SectionViewModel1 {
            array = obj.getStorage()
        } else if let obj = data[1] as? SectionViewModel2 {
            array = obj.getStorage()
        }
        for i in 0..<10 {
            array[i] = CellViewModel(name: String(i+1), data: search + " " + String(i+1))
        }
        data[1] = SectionViewModel2(array: array)
        dataSource.setData(array: data)
        
        adapter.performUpdates(animated: false, completion: nil)
    }
}
extension ViewController: CellDelegate {
    func searchTerm() -> String {
        return search
    }
    
}
