//
//  HabitViewController.swift
//  MyHabits
//
//  Created by mitr on 04.04.2022.
//

import UIKit

class HabitViewController: UIViewController {
    
    var habitItem: Habit?
    var closeClosure: (() -> Void)?

    private let labelName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.text = "Название"
        label.text = label.text?.uppercased()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.becomeFirstResponder()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let labelColor: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.text = "Цвет"
        label.text = label.text?.uppercased()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var colorField: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let labelDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.text = "Время"
        label.text = label.text?.uppercased()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelDateText: UILabel = {
        let label = UILabel()
        label.text = "Каждый день в"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateText: UILabel = {
        let label = UILabel()
        
        if let date = habitItem?.date {
            label.text = dateFormatter.string(from: date)
        } else {
            label.text = dateFormatter.string(from: dateField.date)
        }
        
        label.textColor = UIColor(named: "AccentColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateField: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.addTarget(self, action: #selector(changedTimePicker), for: .valueChanged)
        return picker
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Отменить",
            style: .plain,
            target: self,
            action: #selector(closePresent))
        
        if habitItem != nil {
            title = "Править"
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Сохранить",
                style: .done,
                target: self,
                action: #selector(saveEditedHabit))
            
        } else {
            title = "Создать"
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Сохранить",
                style: .done,
                target: self,
                action: #selector(addNewHabit))
        }
        setupUI()
        tapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "AppGray")
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        if habitItem != nil {
            deleteButton.isHidden = false
            updateHabitItem()
        }
    }
    
    
    
    private func updateHabitItem() {
        textField.text = habitItem?.name
        textField.textColor = habitItem?.color
        textField.font = .systemFont(ofSize: 17, weight: .semibold)
        colorField.backgroundColor = habitItem?.color
        dateField.date = habitItem!.date
    }
    
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showColorPicker))
        colorField.addGestureRecognizer(tapGesture)
    }
    
    @objc private func showColorPicker() {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.title = "Выберите цвет"
        picker.selectedColor = habitItem?.color ?? .orange
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc private func changedTimePicker() {
        dateText.text = dateFormatter.string(from: dateField.date)
    }
    
    @objc private func addNewHabit() {
        if let text = textField.text, !text.isEmpty {
            let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
            let newHabit = Habit(name: trimmedText,
                                 date: dateField.date,
                                 color: colorField.backgroundColor!)
            HabitsStore.shared.habits.append(newHabit)
            dismiss(animated: true)
        }
    }
    
    @objc private func saveEditedHabit() {
        if let editedHabit = habitItem {
            let habit = HabitsStore.shared.habits.first(where: {$0 == editedHabit})
            
            if let text = textField.text {
                let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
                habit?.name = trimmedText
                habit?.color = colorField.backgroundColor!
                habit?.date = dateField.date
                HabitsStore.shared.save()
                dismiss(animated: true)
            }
        }

    }
    
    @objc private func closePresent() {
        dismiss(animated: true)
    }
    
    @objc private func deleteHabit() {
        let alert = UIAlertController(
            title: "Удалить привычку",
            message: "Вы хотите удалить привычку \(habitItem?.name ?? "")?",
            preferredStyle: .alert)
        
        let cancel = UIAlertAction(
            title: "Отмена",
            style: .cancel,
            handler: nil)
        alert.addAction(cancel)
        
        let destructive = UIAlertAction(
            title: "Удалить",
            style: .destructive,
            handler: {_ in
                if let removingHabit = self.habitItem {
                    HabitsStore.shared.habits.removeAll(where: {$0 == removingHabit})
                    self.dismiss(animated: false)
                    self.closeClosure?()
                }
            })
        alert.addAction(destructive)
        present(alert, animated: true, completion: nil)
    }
    
    private func setupUI() {
        [labelName, textField, labelColor, colorField, labelDate, labelDateText, dateText, dateField, deleteButton].forEach({view.addSubview($0)})
        
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            labelName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            textField.heightAnchor.constraint(equalToConstant: 22),
            textField.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 7),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            textField.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            
            labelColor.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15),
            labelColor.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            
            colorField.widthAnchor.constraint(equalToConstant: 30),
            colorField.heightAnchor.constraint(equalToConstant: 30),
            colorField.topAnchor.constraint(equalTo: labelColor.bottomAnchor, constant: 7),
            colorField.leadingAnchor.constraint(equalTo: labelColor.leadingAnchor),
            
            labelDate.topAnchor.constraint(equalTo: colorField.bottomAnchor, constant: 15),
            labelDate.leadingAnchor.constraint(equalTo: colorField.leadingAnchor),
            
            labelDateText.topAnchor.constraint(equalTo: labelDate.bottomAnchor, constant: 7),
            labelDateText.leadingAnchor.constraint(equalTo: colorField.leadingAnchor),
            
            dateText.topAnchor.constraint(equalTo: labelDateText.topAnchor),
            dateText.leadingAnchor.constraint(equalTo: labelDateText.trailingAnchor, constant: 4),
            
            dateField.topAnchor.constraint(equalTo: dateText.bottomAnchor, constant: 15),
            dateField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dateField.leadingAnchor.constraint(equalTo: labelDateText.leadingAnchor),
            
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -18)
        ])
    }
}



extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorField.backgroundColor = viewController.selectedColor
    }
}

extension HabitViewController: UITextFieldDelegate {
    override func resignFirstResponder() -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
}
