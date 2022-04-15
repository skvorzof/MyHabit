//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by mitr on 05.04.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private let progressView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "Всё получится!"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressInfo: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 1.7)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupCell(percent: Float) {
        progressInfo.text = "\(Int(percent * 100))%"
        progressBar.setProgress(percent, animated: false)
    }
    
    
    
    private func layout() {
        addSubview(progressView)
        [progressLabel, progressInfo, progressBar].forEach({progressView.addSubview($0)})
        
        NSLayoutConstraint.activate([
            progressView.heightAnchor.constraint(equalToConstant: 60),
            progressView.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            progressLabel.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 10),
            progressLabel.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 12),
            
            progressInfo.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 10),
            progressInfo.trailingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: -12),
            
            progressBar.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 10),
            progressBar.trailingAnchor.constraint(equalTo: progressInfo.trailingAnchor),
            progressBar.leadingAnchor.constraint(equalTo: progressLabel.leadingAnchor)
        ])
    }
}
