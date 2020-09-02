//
//  DoctorCollection.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/27/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import IGListKit
import UIKit

class DoctorCollection: NSObject, ListDiffable {
    let id: Int
    let doctors: [DoctorCard]
    
    init(id: Int, doctors: [DoctorCard]) {
        self.id = id
        self.doctors = doctors
        super.init()
    }
    
    // MARK: ListDiffable Protocol
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : self.isEqual(object)
    }
}

class DoctorSectionController: ListSectionController {
    
    private var doctor: DoctorCard?
    private var doctorCollection: DoctorCollection!

    required init(doctorCollection: DoctorCollection) {
        self.doctorCollection = doctorCollection
        super.init()
        self.minimumLineSpacing = 26
    }
    override func sizeForItem(at index: Int) -> CGSize {
       return CGSize(width: 168, height: 202)
    }

    override func numberOfItems() -> Int {
        return doctorCollection.doctors.count
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {

        guard let cell: DoctorCollectionCell = collectionContext?.dequeueReusableCell(of: DoctorCollectionCell.self, for: self, at: index) as? DoctorCollectionCell else {
            fatalError()
        }
        cell.data = doctorCollection.doctors[index]
        cell.viewController = viewController
        return cell
    }

    override func didUpdate(to object: Any) {
        self.doctor = object as? DoctorCard
    }

    override func didSelectItem(at index: Int) {
        print("list handler \(index)")
    }

}

fileprivate class DoctorCollectionCell: UICollectionViewCell, ListBindable {
    
    var viewController: UIViewController!
    
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? DoctorCard else { return }
        data = viewModel
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var data: DoctorCard? {
        didSet {
            guard let data = data else { return }
            doctorPhoto.image = UIImage(named: data.photo)
            name.text = data.name
            category.text = data.category
            let content3 = String.scanFor(key: .doctors_collection_center)
            let content4 = String.scanFor(key: .doctors_collection_button_connect)
            if !data.isAvailable {
                let content1 = String.scanFor(key: .doctors_collection_button_offline)
                let attributedString = NSAttributedString(string: content1.text ?? "EMPTY TEXT", attributes: [NSAttributedString.Key.font: content1.getFont(), NSAttributedString.Key.foregroundColor: content1.getTextColor()])
                availabilityButton.backgroundColor = content1.getBackgroundColor()
                availabilityButton.setAttributedTitle(attributedString, for: .normal)
                
                let content2 = String.scanFor(key: .doctors_collection_center_available)
                let content3 = String.scanFor(key: .doctors_collection_center)
                let paragraphstyle1: NSMutableParagraphStyle = NSMutableParagraphStyle()
                paragraphstyle1.alignment = .left
                let attributedText1 = NSMutableAttributedString(string: "Disponible en", attributes: [NSAttributedString.Key.font: content3.getFont(), NSAttributedString.Key.paragraphStyle: paragraphstyle1])
                let attributedText2 = content2.getAttributedText(alignment: .center, for: "\(data.availableIn) \(data.availableIn == 1 ? "min" : "mins")\naprox.")
                //attributedText1.append(attributedText2)
                //attributedText1.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphstyle, range: NSRange(location: 0, length: attributedText1.length))
                centerAvailableIn.attributedText = attributedText2
                centerAvailableIn.isHidden = false
                centerText.attributedText = attributedText1
                centerText.textColor = content2.getTextColor()
                centerText.contentOffset = CGPoint(x: -8, y: -8)
                bottomButton.setAttributedTitle(NSAttributedString(string: "Solicitar consulta", attributes: [NSAttributedString.Key.font: content4.getFont(), NSAttributedString.Key.foregroundColor: content4.getTextColor()]), for: .normal)
                bottomButton.setAttributedTitle(NSAttributedString(string: "Solicitar consulta", attributes: [NSAttributedString.Key.font: content4.getFont(), NSAttributedString.Key.foregroundColor: content4.getTextColor()]), for: .highlighted)
                bottomButton.setAttributedTitle(NSAttributedString(string: "Solicitar consulta", attributes: [NSAttributedString.Key.font: content4.getFont(), NSAttributedString.Key.foregroundColor: content4.getTextColor()]), for: .selected)
                bottomButton.setImage(#imageLiteral(resourceName: "gray"), for: .normal)
                bottomButton.setImage(#imageLiteral(resourceName: "gray"), for: .highlighted)
                bottomButton.setImage(#imageLiteral(resourceName: "gray"), for: .selected)
            }
            else {
                let content1 = String.scanFor(key: .doctors_collection_button_online)
                let attributedString = NSAttributedString(string: content1.text ?? "EMPTY TEXT", attributes: [NSAttributedString.Key.font: content1.getFont(), NSAttributedString.Key.foregroundColor: content1.getTextColor()])
                availabilityButton.backgroundColor = content1.getBackgroundColor()
                availabilityButton.setAttributedTitle(attributedString, for: .normal)
                
                centerAvailableIn.isHidden = true
                centerText.attributedText = nil
                centerText.textAlignment = .center
                centerText.text = "Disponible ahora mismo"
                centerText.textColor = content3.getTextColor()
                centerText.contentOffset = CGPoint(x: 0, y: -8)
       
                bottomButton.setAttributedTitle(NSAttributedString(string: "Conectarme", attributes: [NSAttributedString.Key.font: content4.getFont(), NSAttributedString.Key.foregroundColor: content4.getTextColor()]), for: .normal)
                bottomButton.setAttributedTitle(NSAttributedString(string: "Conectarme", attributes: [NSAttributedString.Key.font: content4.getFont(), NSAttributedString.Key.foregroundColor: content4.getTextColor()]), for: .highlighted)
                bottomButton.setAttributedTitle(NSAttributedString(string: "Conectarme", attributes: [NSAttributedString.Key.font: content4.getFont(), NSAttributedString.Key.foregroundColor: content4.getTextColor()]), for: .selected)
                bottomButton.setImage(#imageLiteral(resourceName: "green"), for: .normal)
                bottomButton.setImage(#imageLiteral(resourceName: "green"), for: .highlighted)
                bottomButton.setImage(#imageLiteral(resourceName: "green"), for: .selected)
            }
        }
    }
    
    lazy private var doctorPhoto: UIImageView = {
        let imageView = UIImageView.photo()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    lazy private var name: UILabel = {
        let textView = UILabel.label()
        textView.backgroundColor = .clear
        textView.font = String.scanFor(key: .doctors_collection_name).getFont()
        textView.textColor = String.scanFor(key: .doctors_collection_name).getTextColor()
        textView.textAlignment = .left
        return textView
    }()
    
    lazy private var category: UILabel = {
        let textView = UILabel.label()
        textView.backgroundColor = .clear
        textView.font = String.scanFor(key: .doctors_collection_category).getFont()
        textView.textColor = String.scanFor(key: .doctors_collection_category).getTextColor()
        textView.textAlignment = .left
        return textView
    }()
    
    lazy private var availabilityButton: UIButton = {
        let content = String.scanFor(key: .doctors_collection_button_online)
        let attributedString = NSAttributedString(string: content.text ?? "EMPTY TEXT", attributes: [NSAttributedString.Key.font: content.getFont(), NSAttributedString.Key.foregroundColor: content.getTextColor()])
        let button = UIButton.mainButton(text: attributedString, radius: CGFloat(content.getRadius()), backGroundColor: content.getBackgroundColor())
        return button
    }()
    
    lazy private var centerText: UITextView = {
        let textView = UITextView.textView()
        let content = String.scanFor(key: .doctors_collection_center)
        textView.backgroundColor = content.getBackgroundColor()
        textView.font = content.getFont()
        textView.layer.cornerRadius = CGFloat(content.getRadius())
        textView.layer.masksToBounds = true
        textView.textColor = content.getTextColor()
        textView.layer.borderColor = content.getBorders().0.cgColor
        textView.layer.borderWidth = CGFloat(content.getBorders().1)
        return textView
    }()
    
    lazy public var bottomButton: UIButton = {
        let content = String.scanFor(key: .doctors_collection_button_connect)
        let button = UIButton.customButton(text: NSAttributedString(string: "Conectarme", attributes: [NSAttributedString.Key.font: content.getFont(), NSAttributedString.Key.foregroundColor: content.getTextColor()]), icon: #imageLiteral(resourceName: "green"), selector: #selector(connectNow), target: self)
        button.contentHorizontalAlignment = .right
        button.contentVerticalAlignment = .center
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 132, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 43)
        return button
    }()
    
    lazy private var centerAvailableIn: UITextView = {
        let textView = UITextView.textView()
        let content = String.scanFor(key: .doctors_collection_center_available)
        textView.backgroundColor = .clear
        textView.textColor = content.getTextColor()
        textView.isHidden = true
        return textView
    }()
    
    lazy var constraints1 = [
        self.content.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
        self.content.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
        self.content.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
    ]
    
    lazy private var content: UIView = {
        let content_ = UIView(frame: .zero)
        content_.translatesAutoresizingMaskIntoConstraints = false
        content_.backgroundColor = .white
        content_.layer.cornerRadius = 6
        content_.layer.masksToBounds = false
        content_.layer.shadowColor = UIColor.gray.cgColor
        content_.layer.shadowOffset = CGSize(width: 0, height: 2)
        content_.layer.shadowOpacity = 0.2
        content_.layer.shadowRadius = 2
        content_.addSubview(self.name)
        content_.addSubview(self.category)
        content_.addSubview(self.availabilityButton)
        content_.addSubview(self.bottomButton)
        content_.addSubview(self.centerText)
        content_.addSubview(self.centerAvailableIn)
        
        //self.addSubview(ava)
        return content_
    }()
    
    func setConstraints(constraints: [NSLayoutConstraint]) {
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func connectNow() {
        print("list handler")
        if let doctor = data {
            let controller = ConsultationPopover(doctor: doctor)
            controller.modalPresentationStyle = .overCurrentContext
            controller.onStartConsulation = { doctor in
                let controller = StartConsulation(doctor: doctor)
                controller.onStartConsulation = { doctor in
                    if doctor.isAvailable {
                        self.viewController.navigationController?.pushViewController(CallSettingsInCall(doctor: doctor), animated: true)
                    }
                    else {
                        let controller = AlertPopover(title: "Solicitar consulta", description: "Cuando solicites una consulta, nosotros te notificaremos a tu celular el momento en que nuestro médico se encuentre disponible para tu consulta.", icon: #imageLiteral(resourceName: "appointment"), doctor: doctor)
                        controller.modalPresentationStyle = .overCurrentContext
                        self.viewController.present(controller, animated: true) {
                            
                        }
                    }
                }
                controller.modalPresentationStyle = .overCurrentContext
                self.viewController.present(controller, animated: true) {
                }
            }
            self.viewController.present(controller, animated: true) {
            }
        }
    }
    
    func setupLayout() {
        addSubview(self.content)
        addSubview(self.doctorPhoto)
        content.frame = CGRect(x: self.contentView.bounds.minX, y: self.contentView.bounds.minY+30, width: self.contentView.bounds.width, height: self.contentView.bounds.height-30)
        doctorPhoto.frame = CGRect(x: 11, y: 0, width: 60, height: 60)
        name.frame = CGRect(x: 11, y: 32, width: self.contentView.bounds.width, height: 15)
        category.frame = CGRect(x: 11, y: 50, width: self.contentView.bounds.width, height: 10)
        availabilityButton.frame = CGRect(x: 88, y: 5, width: 75, height: 24)
        centerText.frame = CGRect(x: 8, y: 80, width: 152, height: 43)
        centerAvailableIn.frame = CGRect(x: 70, y: 80, width: 100, height: 43)
        bottomButton.frame = CGRect(x: 0, y: 122, width: 168, height: 43)
//        self.contentView.bringSubviewToFront(doctorPhoto)
//        self.contentView.bringSubviewToFront(name)
//        self.contentView.bringSubviewToFront(category)
//        self.contentView.bringSubviewToFront(availabilityButton)
//        self.contentView.bringSubviewToFront(centerText)
//        self.contentView.bringSubviewToFront(centerAvailableIn)
//        self.contentView.bringSubviewToFront(bottomButton)
        if let data = self.data {
            if data.isAvailable {
                centerText.contentOffset = CGPoint(x: 0, y: -8)
            }
            else {
                centerText.contentOffset = CGPoint(x: -8, y: -8)
            }
        }
        else {
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //print("contentOffset: \(centerText.contentOffset) alignmentRectInsets: \(centerText.alignmentRectInsets) bounds: \(centerText.bounds) frame: \(centerText.frame)")

    }
    
}
