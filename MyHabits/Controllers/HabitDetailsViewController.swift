//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by mitr on 05.04.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    var habitItem: Habit?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "AppBackground")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Править",
            style: .plain,
            target: self,
            action: #selector(editHabit))
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = habitItem?.name
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    
    
    @objc private func editHabit() {
        let habitVC = HabitViewController()
        habitVC.habitItem = self.habitItem
        let nc = UINavigationController(rootViewController: habitVC)
        nc.modalPresentationStyle = .fullScreen

        habitVC.closeClosure = {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        present(nc, animated: true)
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}



extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        let date = HabitsStore.shared.dates.sorted(by: >)[indexPath.row]
        let habit = HabitsStore.shared.habits.filter({$0.name == habitItem?.name})
        
        for item in habit {
            let isChecked = HabitsStore.shared.habit(item, isTrackedIn: date)
            if isChecked {
                cell.accessoryType = .checkmark
            }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.doesRelativeDateFormatting = true
        dateFormatter.dateStyle = .long

        var configuration = cell.defaultContentConfiguration()
        configuration.text = dateFormatter.string(from: date)
        cell.contentConfiguration = configuration
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Активность"
    }
}
