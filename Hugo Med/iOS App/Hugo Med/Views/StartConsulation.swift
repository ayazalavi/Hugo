//
//  ConsultationPopover.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/27/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

class StartConsulation:  HugoMedUIViewController {
    
    let doctor: DoctorCard
    
    let contentStyle: Content = String.scanFor(key: .welcome_title_1)
    let contentStyle2: Content = String.scanFor(key: .welcome_message_1)
    let contentStyle3: Content = String.scanFor(key: .welcome_button)
    
    var onStartConsulation: ((DoctorCard) -> Void)!
    
    // MARK: LIFE CYCLE METHODS, INITIALIZERS, ACTIONS AND EVENTS
    init(doctor: DoctorCard) {
        self.doctor = doctor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarColor = .clear
        navBarTintColor = String.scanFor(key: .nav_bar).getTextColor()
        navBarTitle = nil
        navBarTitleImage = "hugo-logo"
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            self.content.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 27),
            self.content.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -54),
            self.content.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.content.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -54),
            self.agreeButton.heightAnchor.constraint(equalToConstant: 44),
            self.agreeButton.widthAnchor.constraint(equalTo: self.content.widthAnchor),
            self.cancelButton.heightAnchor.constraint(equalToConstant: 44),
            self.cancelButton.widthAnchor.constraint(equalTo: self.content.widthAnchor),
            self.emptyView2.heightAnchor.constraint(equalToConstant: 49),
            self.emptyView2.widthAnchor.constraint(equalTo: self.content.widthAnchor),
            self.emptyView3.heightAnchor.constraint(equalToConstant: 12),
            self.emptyView3.widthAnchor.constraint(equalTo: self.content.widthAnchor),
        ])
//        self.agreeButton.topAnchor.constraint(equalTo: self.subtitleText.bottomAnchor, constant: 49),
//
//        self.titleText.topAnchor.constraint(equalTo: self.mainPhoto.bottomAnchor, constant: 45),
//                   self.subtitleText.topAnchor.constraint(equalTo: self.titleText.bottomAnchor, constant: 31),
    }
    
    @objc func startConsulation() {
        self.dismiss(animated: true) {
            self.onStartConsulation(self.doctor)
        }
    }
    
    @objc func cancel() {
        self.dismiss(animated: true) {
            
        }
    }
    
    @objc func recheckStatus(_ sender: UIGestureRecognizer) {
        print("tapped")
    }
    
    // MARK: VIEWs
    lazy private var content: UIStackView = {
        let view_ = UIStackView(arrangedSubviews: [mainPhoto, titleText, emptyView1, subtitleText, emptyView2, agreeButton, emptyView3, cancelButton])
        view_.distribution = .fill
        view_.alignment = .center
        view_.axis = .vertical
        view_.backgroundColor = .white
        view_.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view_)
        return view_
    }()
    
    private var emptyView: UIView  {
        let textView = UIView(frame: .zero)
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }
    
    
    lazy private var mainPhoto: UIImageView = UIImageView.photo(name: "startmedic-med")
    
    lazy private var titleText: UITextView  = {
        let textView = UITextView.textView()
        textView.backgroundColor = .clear
        textView.font = self.contentStyle.getFont()
        textView.textColor = self.contentStyle.getTextColor()
        textView.textAlignment = .center
        textView.text = "Inicia tu cuadro médico"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var emptyView1 = {
        return emptyView
    }()
    
    lazy var emptyView2 = {
        return emptyView
    }()
    
    lazy var emptyView3 = {
        return emptyView
    }()
    
    lazy private var subtitleText: UITextView  = {
        let textView = UITextView.textView()
        textView.backgroundColor = .clear
        textView.font = self.contentStyle2.getFont()
        textView.textColor = self.contentStyle2.getTextColor()
        textView.textAlignment = .center
        textView.text = "Al iniciar con nuestro servicio, compartiremos tus datos de nombre y correo electrónico a nuestro partner médico, para crear un historial médico y darte un mejor en cada consulta."
        return textView
    }()

    lazy private var agreeButton: UIButton = {
        let button = UIButton.mainButton(text: NSMutableAttributedString(string: "ESTOY DE ACUERDO", attributes: [NSAttributedString.Key.font: self.contentStyle3.getFont(), NSAttributedString.Key.foregroundColor: self.contentStyle3.getTextColor()]), radius: CGFloat(contentStyle3.getRadius()), backGroundColor: contentStyle3.getBackgroundColor(), spacing: 1.73)
        button.addTarget(self, action: #selector(startConsulation), for: .touchUpInside)
        return button
    }()
    
    lazy private var cancelButton: UIButton = {
        let button = UIButton.mainButton(text: NSMutableAttributedString(string: "CANCELAR SOLICITUD", attributes: [NSAttributedString.Key.font: self.contentStyle3.getFont(), NSAttributedString.Key.foregroundColor: self.contentStyle2.getTextColor()]), radius: CGFloat(contentStyle3.getRadius()), backGroundColor: .white, spacing: 1.73)
        button.layer.borderColor = UIColor.hexStringToUIColor(hex: "#E2DDED").cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()
}
