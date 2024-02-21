//
//  CalendarViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/21/24.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: BaseViewController {
    
    let calendar = FSCalendar()
    let tableView = UITableView()
    
    var list: Results<ToDoTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        view.addSubview(calendar)
        view.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()
        
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.backgroundColor = .clear
        calendar.scrollDirection = .vertical
        calendar.appearance.headerTitleColor = .white
        calendar.appearance.weekdayTextColor = .white
        calendar.appearance.titleDefaultColor = .white
        calendar.appearance.titleWeekendColor = .red
        
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
    }
    
    override func configureConstraints() {
        calendar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(350)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let start = Calendar.current.startOfDay(for: date)
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "deadline >= %@ && deadline < %@", start as NSDate, end as NSDate)
        
        return ToDoTableData.shared.allData.filter(predicate).count
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let start = Calendar.current.startOfDay(for: date)
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "deadline >= %@ && deadline < %@", start as NSDate, end as NSDate)
        
        list = ToDoTableData.shared.allData.filter(predicate)
        tableView.reloadData()
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list else { return 0 }
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as! ToDoTableViewCell
        cell.configureView(item: list[indexPath.row])
        return cell
    }
}
