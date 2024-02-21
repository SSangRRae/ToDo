//
//  ListViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/14/24.
//

import UIKit
import RealmSwift

class MainViewController: BaseViewController {
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.searchTextField.attributedPlaceholder = NSAttributedString(string: "검색", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray.cgColor])
        view.barTintColor = .black
        return view
    }()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    let listTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "나의 목록"
        view.font = .boldSystemFont(ofSize: 25)
        view.textColor = .white
        return view
    }()
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    var list: Results<Lists>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTableRepository.readAll()
        list = listsRepository.readAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    override func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(listTitleLabel)
        view.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()
        
        configureNavigation()
        configureToolBar()
        
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ToDoCollectionViewCell.self, forCellWithReuseIdentifier: ToDoCollectionViewCell.identifier)
        
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyListTableViewCell.self, forCellReuseIdentifier: MyListTableViewCell.identifier)
    }
    
    override func configureConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view).inset(8)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view)
            make.height.equalTo(350)
        }
        
        listTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(8)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.height.equalTo(22)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(listTitleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view)
            make.height.equalTo(350)
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyListTableViewCell.identifier, for: indexPath) as! MyListTableViewCell
        cell.configureCell(item: list[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // List -> Results 어떻게..?
//        let vc = SelectListViewController()
//        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToDoCollectionViewCell.identifier, for: indexPath) as! ToDoCollectionViewCell
        
        cell.configureViews(item: MainSection.allCases[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let vc = TodayViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.item == 1 {
            let vc = ExpectedViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
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

extension MainViewController {
    
    func configureNavigation() {
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "calendar.circle"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(rightBarButtonClicked))
        navigationItem.leftBarButtonItem = leftBarButton
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
        let vc = UINavigationController(rootViewController: ListViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func leftBarButtonClicked() {
        
    }
    
    @objc func rightBarButtonClicked() {
        
    }
}
