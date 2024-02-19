//
//  ListViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/14/24.
//

import UIKit
import RealmSwift

class ListViewController: BaseViewController {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "전체"
        view.textColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        view.font = .systemFont(ofSize: 30)
        return view
    }()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    var count = 0
    var completeCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let realm = try! Realm()
        
        count = realm.objects(ToDoTable.self).count
        completeCount = realm.objects(ToDoTable.self).where {
            $0.complete == true
        }.count
        collectionView.reloadData()
    }
    
    override func configureHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }
    
    override func configureView() {
        super.configureView()
        configureNavigation()
        configureToolBar()
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: "listCell")
    }
    
    override func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(view.safeAreaLayoutGuide).offset(8)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ListSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as! ListCollectionViewCell
        
        cell.configureViews(item: ListSection.allCases[indexPath.item])
        if indexPath.item == 2 {
            cell.countLabel.text = "\(count)"
        }
        if indexPath.item == 4 {
            cell.countLabel.text = "\(completeCount)"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 2 {
            let vc = AllListViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.item == 4 {
            let vc = CompleteViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ListViewController {
    
    func configureNavigation() {
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(rightBarButtonClicked))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func configureToolBar() {
        let button = UIButton()
        button.setTitle("새로운 할 일", for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(addNewToDoButtonClicked), for: .touchUpInside)
        let addNewToDoButton = UIBarButtonItem(customView: button)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let addList = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(addListButtonClicked))
        
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.tintColor = .white
        toolbarItems = [addNewToDoButton, flexibleSpace, addList]
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 16
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (space * 3)
        
        layout.itemSize = CGSize(width: cellWidth/2, height: cellWidth/2/1.8)
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        
        return layout
    }
    
    @objc func addNewToDoButtonClicked() {
        let vc = UINavigationController(rootViewController: NewViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func addListButtonClicked() {
        
    }
    
    @objc func rightBarButtonClicked() {
        
    }
}
