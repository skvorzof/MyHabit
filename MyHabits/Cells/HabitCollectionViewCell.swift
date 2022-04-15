//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by mitr on 06.04.2022.
//

import UIKit


class HabitCollectionViewCell: UICollectionViewCell {
        
    private var itemHabit: Habit?
    var delegateReloadData: (() -> Void)?
    
    private let customView: UIView = {
        let customView = UIView()
        customView.backgroundColor = .white
        customView.layer.cornerRadius = 8
        customView.clipsToBounds = true
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()
    
    private let habitTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .blue
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let habitTime: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let habitCount: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var checkerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "checked"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(checkingHabitCheck), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let habitCheck: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 16
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        habitTitle.textColor = .none
        checkerButton.layer.borderColor = .none
        checkerButton.backgroundColor = .none
    }
    
    func setupCell(model: Habit) {
        habitTitle.text = model.name
        habitTitle.textColor = model.color
        habitTime.text = model.dateString
        
        habitCount.text = "Счётчик: \(model.trackDates.count)"
        checkerButton.layer.borderColor = model.color.cgColor
        
        if model.isAlreadyTakenToday {
            checkerButton.backgroundColor = model.color
        }
        itemHabit = model
    }
    
    @objc private func checkingHabitCheck() {
        guard let trackedHabit = itemHabit else {return}

        if !trackedHabit.isAlreadyTakenToday {
            HabitsStore.shared.track(trackedHabit)
            delegateReloadData?()
        }
    }
    
    private func setupUI() {
        let offset: CGFloat = 16
        let inset: CGFloat = 20

        [customView, habitTitle, habitTime, habitCount, checkerButton].forEach({addSubview($0)})

        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: topAnchor),
            customView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset),
            customView.bottomAnchor.constraint(equalTo: bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset),

            habitTitle.topAnchor.constraint(equalTo: customView.topAnchor, constant: inset),
            habitTitle.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: inset),
            
            habitTime.topAnchor.constraint(equalTo: habitTitle.bottomAnchor, constant: 5),
            habitTime.leadingAnchor.constraint(equalTo: habitTitle.leadingAnchor),
            
            habitCount.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -inset),
            habitCount.leadingAnchor.constraint(equalTo: habitTime.leadingAnchor),
            
            checkerButton.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
            checkerButton.widthAnchor.constraint(equalToConstant: 32),
            checkerButton.heightAnchor.constraint(equalToConstant: 32),
            checkerButton.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -inset)
        ])
    }
}
