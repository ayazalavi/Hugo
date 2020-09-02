//
//  Receipt.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/31/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import IGListKit

class ReceiptDetails: NSObject, ListDiffable, Sequence, IteratorProtocol {
    
    let id, date, service: String
    let card: PaymentCard
    let amount, comission: Float
    var last = "ID"
    // MARK: INIT
    required init(id: String, date: String, service: String, card: PaymentCard, amount: Float, comission: Float) {
        self.id = id
        self.date = date
        self.service = service
        self.card = card
        self.amount = amount
        self.comission = comission
        super.init()
    }
    
    // MARK: LIST ADAPTAR
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return object is ReceiptDetails && (object as? ReceiptDetails)?.id == self.id
    }
    
    // MARK: ITERATOR
    func next() -> (String, Any)? {
        switch last {
        case "ID":
            last = "DATE"
            return ("ID de transación", self.id)
        case "DATE":
            last = "SERVICE"
            return ("Fecha y hora", self.date)
        case "SERVICE":
            last = "CARD"
            return ("Servicio", self.service)
        case "CARD":
            last = "COMMISION"
            return ("Tarjeta debitada", self.card)
        case "COMMISION":
            last = "TOTAL"
            return ("Comisión por servicio", "$\(self.comission)")
        case "TOTAL":
            last = ""
            return ("Total", "$\(self.amount)")
        default:
            return nil
        }
    }
}

class Receipt: NSObject, ListDiffable {

    let payment: Payment
    let details: ReceiptDetails
    
    init(with payment: Payment, details: ReceiptDetails) {
        self.payment = payment
        self.details = details
        super.init()
    }
    
    // MARK: LIST ADAPTAR
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return object is Receipt && (object as? Receipt)?.details.id == self.details.id
    }
    
}


// MARK: Amount IGListSection

class AmountSectionController: ListSectionController {

    private var object: Receipt?

    required override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 96)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {

        guard let cell: AmountCell = collectionContext?.dequeueReusableCell(of: AmountCell.self, for: self, at: index) as? AmountCell else {
            fatalError()
        }
        //cell.text = object?.items[index] ?? "undefined"
        cell.data = object?.payment
        cell.backgroundColor = .clear
        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? Receipt
    }

    override func didSelectItem(at index: Int) {
        print("amount list handler \(index)")
    }
}


fileprivate class AmountCell: UICollectionViewCell, ListBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? Payment else { return }
        data = viewModel
    }
    
    let style1: Content = String.scanFor(key: .popover_card_text)
    
    var data: Payment? {
        didSet {
            guard let data = data else { return }
            let text1 = NSMutableAttributedString(string: "$\(data.amount)", attributes: [NSAttributedString.Key.font: UIFont.getFont(name: Fonts.GothamBook.rawValue, size: 48), NSAttributedString.Key.foregroundColor: UIColor.white])
            label2.attributedText = text1
        }
    }
    
    var label1 = UILabel(frame: .zero)
    
    var label2 = UILabel(frame: .zero)
    
    var label3 = UILabel(frame: .zero)
    
    lazy var topStack: UIStackView = {
        
        label1.attributedText =  NSAttributedString(string: "Haz pagado", attributes: [NSAttributedString.Key.font: style1.getFont(), NSAttributedString.Key.foregroundColor: UIColor.white])
        let text3 = NSMutableAttributedString(string: "en ", attributes: [NSAttributedString.Key.font: UIFont.getFont(name: Fonts.GothamMedium.rawValue, size: 13), NSAttributedString.Key.foregroundColor: UIColor.white])
        text3.append(NSAttributedString(string: "hugo", attributes: [NSAttributedString.Key.font: UIFont.getFont(name: Fonts.GothamUltra.rawValue, size: 13), NSAttributedString.Key.foregroundColor: UIColor.white]))
        text3.append(NSAttributedString(string: "Med", attributes: [NSAttributedString.Key.font: UIFont.getFont(name: Fonts.GothamMedium.rawValue, size: 13), NSAttributedString.Key.foregroundColor: UIColor.white]))
        label3.attributedText = text3
        let stackView_ = UIStackView(arrangedSubviews: [label1, label2, label3])
        stackView_.axis = .vertical
        stackView_.spacing = 8
        stackView_.alignment = .center
        self.addSubview(stackView_)
        return stackView_
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topStack.frame = contentView.bounds
    }
    
}

// MARK: Receipt Details IGListSection

class ReceiptDetailsSectionController: ListSectionController {

    private var object: ReceiptDetails?

    required override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 25, left: 0, bottom: -10, right: 0)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: (collectionContext?.containerSize.width ?? 0)-28, height: 585)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {

        guard let cell: ReceiptCell = collectionContext?.dequeueReusableCell(of: ReceiptCell.self, for: self, at: index) as? ReceiptCell else {
            fatalError()
        }
        //cell.text = object?.items[index] ?? "undefined"
        cell.data = object
        cell.backgroundColor = .clear
        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? ReceiptDetails
    }

    override func didSelectItem(at index: Int) {
        print("amount details handler \(index)")
    }
}


fileprivate class ReceiptCell: UICollectionViewCell, ListBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? ReceiptDetails else { return }
        data = viewModel
    }
    
    let style1: Content = String.scanFor(key: .popover_card_text)
    
    var data: ReceiptDetails? {
        didSet {
            guard let data = data else { return }
            //labels_.removeAll()
            _ = receiptDetails.arrangedSubviews.map {
                receiptDetails.removeArrangedSubview($0)
            }
            for object in data {
                if object.0 == "Comisión por servicio" || object.0 == "ID de transación" {
                    let label = UILabel.label()
                    label.textAlignment = .left
                    label.attributedText =  NSAttributedString(string: object.0 == "ID de transación" ? "DETALLE DE TRANSACCIÓN": "DETALLE DE FACTURACIÓN", attributes: [NSAttributedString.Key.font: UIFont.getFont(name: Fonts.GothamBold.rawValue, size: 12), NSAttributedString.Key.foregroundColor: UIColor.hexStringToUIColor(hex: "#3C1B5D"), NSAttributedString.Key.kern: 1.38])
                   // labels_.append(label)
                    receiptDetails.addArrangedSubview(label)
                }
                let label = UILabel.label()
                label.textAlignment = .left
                label.font = object.0 == "Total" ? UIFont.getFont(name: Fonts.GothamBold.rawValue, size: 15) : UIFont.getFont(name: Fonts.GothamBook.rawValue, size: 13)
                label.textColor = UIColor.hexStringToUIColor(hex: "#8777B2")
                let attributedString = NSMutableAttributedString(string: "\(object.0)\n")
                //var length: Int = 0
                if let card = object.1 as? PaymentCard {
                 ///   length = "  ****\(card.number)".count
                    attributedString.append(NSAttributedString(string: "  **** \(card.number)"))
                }
                else if let textData = object.1 as? String {
                    //length = textData.count
                    attributedString.append(NSAttributedString(string: "\(textData)"))
                }
                
                let p1 = NSMutableParagraphStyle()
                let p2 = NSMutableParagraphStyle()
                p1.alignment = .left
                p2.alignment = .right
                p2.paragraphSpacingBefore = -1 * (label.font.lineHeight)
                attributedString.addAttribute(.paragraphStyle, value: p1, range: NSRange(location: 0, length: object.0.count))
                attributedString.addAttribute(.paragraphStyle, value: p2, range: NSRange(location: object.0.count, length:attributedString.length - object.0.count))
                
                switch object.1 {
                case let card as PaymentCard where card.type == "VISA":
                    attributedString.addAttribute(.font, value: UIFont.getFont(name: Fonts.GothamBold.rawValue, size: 13), range: NSRange(location: object.0.count, length: attributedString.length-object.0.count))
                case let str as String where str == "hugoMed":
                    attributedString.addAttribute(.font, value: UIFont.getFont(name: Fonts.GothamBook.rawValue, size: 13), range: NSRange(location: object.0.count, length: attributedString.length-object.0.count))
                    attributedString.addAttribute(.font, value: UIFont.getFont(name: Fonts.GothamUltra.rawValue, size: 13), range: NSRange(location: object.0.count+1, length: 4))
                default:
                    attributedString.addAttribute(.font, value: UIFont.getFont(name: Fonts.GothamBold.rawValue, size: object.0 == "Total" ? 15 : 13), range: NSRange(location: object.0.count, length: attributedString.length-object.0.count))
                }
                label.numberOfLines = 0
                label.attributedText = attributedString
                //labels_.append(label)
                receiptDetails.addArrangedSubview(label)
            }
            
        }
    }
    
    var title = UILabel(frame: .zero)
    
    var subtitle = UILabel(frame: .zero)
    
    var heading1 = UILabel(frame: .zero)
    
    var heading2 = UILabel(frame: .zero)
    
    lazy var container: UIView = {
        let stackView_ = UIView(frame: .zero)
        stackView_.backgroundColor = .white
        stackView_.layer.cornerRadius = 6
        stackView_.layer.masksToBounds = false
        stackView_.layer.shadowColor = UIColor.hexStringToUIColor(hex: "#474A52").cgColor
        stackView_.layer.shadowOffset = CGSize(width: 4, height: 3)
        stackView_.layer.shadowOpacity = 0.09
        //stackView_.layer.shadowRadius = 3
        stackView_.addSubview(innerContainer)
        stackView_.addSubview(visa)
        self.addSubview(stackView_)
        return stackView_
    }()
    
    lazy var innerContainer: UIStackView = {
        let stackView_ = UIStackView(arrangedSubviews: [titleStackView, lineView, receiptDetails, self.emptyView])
        stackView_.axis = .vertical
//        stackView_.setCustomSpacing(17, after: self.titleStackView)
//         stackView_.setCustomSpacing(17, after: self.titleStackView)
        stackView_.spacing =  17
        //stackView_.layer.shadowRadius = 3
        return stackView_
    }()
    
    lazy var titleStackView: UIStackView = {
        self.title.attributedText =  NSAttributedString(string: "NOTA DE TRANSACCIÓN", attributes: [NSAttributedString.Key.font: UIFont.getFont(name: Fonts.GothamBold.rawValue, size: 12), NSAttributedString.Key.foregroundColor: UIColor.hexStringToUIColor(hex: "#3C1B5D"), NSAttributedString.Key.kern: 1.38])
        let text1 = NSMutableAttributedString(string: "Uso de servicios en ", attributes: [NSAttributedString.Key.font: UIFont.getFont(name: Fonts.GothamBook.rawValue, size: 13)])
        text1.append(NSAttributedString(string: "hugo", attributes: [NSAttributedString.Key.font: UIFont.getFont(name: Fonts.GothamUltra.rawValue, size: 13)]))
        text1.append(NSAttributedString(string: "Med", attributes: [NSAttributedString.Key.font: UIFont.getFont(name: Fonts.GothamMedium.rawValue, size: 13)]))
        self.subtitle.attributedText = text1
        self.subtitle.textColor = UIColor.hexStringToUIColor(hex: "#8777B2")
        let stackView_ = UIStackView(arrangedSubviews: [self.title, self.subtitle])
        stackView_.setCustomSpacing(8, after: self.title)
        stackView_.axis = .vertical
        stackView_.spacing = 22
        stackView_.alignment = .leading
        stackView_.layoutMargins = UIEdgeInsets(top: 22, left: 22, bottom: 22, right: 22)
        stackView_.isLayoutMarginsRelativeArrangement = true
        return stackView_
    }()
    
   // var labels_ = [UILabel]()
    
    lazy var receiptDetails: UIStackView = {
        let stackView_ = UIStackView(arrangedSubviews: [])
        stackView_.axis = .vertical
        stackView_.alignment = .leading
        stackView_.spacing = 32
        stackView_.alignment = .fill
        stackView_.layoutMargins = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        stackView_.isLayoutMarginsRelativeArrangement = true
        return stackView_
    }()
    
    var emptyView: UIView {
        return UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    }
    
    lazy var lineView: DashView = {
        let label_ = DashView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 20))
        label_.backgroundColor = .clear
        return label_
    }()
    
    lazy var visa: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo-card"))
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        container.frame = self.bounds
        visa.frame = CGRect(x: 219, y: 320, width: 31, height: 10)
        innerContainer.frame = self.bounds
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 20),
        ])
        print(receiptDetails.bounds)

    }
    
}

class DashView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawHalfCircle(at: .zero)
        for index in stride(from: 10, to: rect.size.width, by: 16) {
            guard index < rect.size.width-1 else {
                drawHalfCircle(at: CGPoint(x: index, y: 0))
                break;
            }
            let dashrect = CGRect(x:index, y:0, width:8, height:1)
            UIColor.hexStringToUIColor(hex: "#D2B6F0").setFill()
            UIRectFill(dashrect)
        }
    }
    
    func drawHalfCircle (at: CGPoint) {
        let circlePath = UIBezierPath(arcCenter: at, radius: CGFloat(10),
                startAngle: CGFloat(0),
                endAngle:CGFloat(Double.pi * 2),
                clockwise: true)
         let shapeLayer = CAShapeLayer()
         shapeLayer.path = circlePath.cgPath
         shapeLayer.fillColor = UIColor.hexStringToUIColor(hex: "#D2B6F0").cgColor
         shapeLayer.strokeColor = UIColor.clear.cgColor
         layer.addSublayer(shapeLayer)
    }
}
