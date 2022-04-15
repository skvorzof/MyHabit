//
//  InfoViewController.swift
//  MyHabits
//
//  Created by mitr on 04.04.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private let infoText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .black
        let htmlString = """
        <h2>Привычка за 21 день</h2>
        <p>Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:</p>
        <p>1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.</p>
        <p>2. Выдержать 2 дня в прежнем состоянии самоконтроля.</p>
        <p>3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.</p>
        <p>4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.</p>
        <p>5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.</p>
        <p>6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.</p>
        """
        textView.attributedText = htmlString.htmlAttributedString()
        textView.isSelectable = false
        textView.contentOffset.y = .zero
        return textView
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Информация"
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "AppGray")
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    
    private func setupUI() {
        view.addSubview(infoText)
        
        NSLayoutConstraint.activate([
            infoText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            infoText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            infoText.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            infoText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
}
