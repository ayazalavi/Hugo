//
//  DoctorsCollection.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/27/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit
import IGListKit

// MARK: Life Cycles Events

class DoctorsCollection: HugoMedUIViewController, ListAdapterDataSource, ListAdapterMoveDelegate {
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var items: [Any] = []  //\n
    
    let doctorsCollection = DoctorCollection(id: 1, doctors: doctors)
    
    let header = NSMutableAttributedString()
    
    lazy var listTitle = CollectionHeading(title: header)
    
    var gotoTerms: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarColor = .clear
        navBarTintColor = String.scanFor(key: .nav_bar).getTextColor()
        navBarTitle = nil
        navBarTitleImage = nil
        self.setBackground()
        
        header.append(NSAttributedString(string: "Queremos ayudarte\n", attributes:
            [NSAttributedString.Key.font: String.scanFor(key: .doctors_collection_title).getFont(), NSAttributedString.Key.foregroundColor: String.scanFor(key: .doctors_collection_title).getTextColor()])
        )
        header.append(NSAttributedString(string: "¿Con quién deseas consultarte?", attributes:
            [NSAttributedString.Key.font: String.scanFor(key: .doctors_collection_subtitle).getFont(), NSAttributedString.Key.foregroundColor: String.scanFor(key: .doctors_collection_subtitle).getTextColor()])
        )
        
        self.items.append(listTitle)
        self.items.append(doctorsCollection)
        
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        if #available(iOS 9.0, *) {
            adapter.moveDelegate = self
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(showNotifyPopover(_:)), name: NSNotification.Name(rawValue: ConsulationStatus.requested.rawValue), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(startCall(_:)), name: NSNotification.Name(rawValue: ConsulationStatus.in_progress.rawValue), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIButton.customButton(image: #imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysTemplate), tintColor: navBarTintColor, selector: #selector(self.navigationController?.popViewController(animated:)), target: self))
        super.viewWillAppear(animated)
        navigationItem.setRightButton(UIButton.customButton(image: #imageLiteral(resourceName: "faq").withRenderingMode(.alwaysTemplate), tintColor: navBarTintColor, selector: #selector(gotoFAQ), target: self))
        print(self.backGroundImage.frame)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 16, y: 0, width: view.bounds.size.width-32, height: view.bounds.height)
    }
    
    
    // MARK: NOTIFICATION METHODS
    
    @objc func showNotifyPopover (_ notification: NSNotification) {
        if let doctor = notification.userInfo?["doctor"] as? DoctorCard {
            let controller = NotifyPopover(doctor: doctor)
            controller.modalPresentationStyle = .overCurrentContext
            self.present(controller, animated: true) {
                if !doctor.isAvailable {
                    Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
                        self.dismiss(animated: true) {
                            let controller = NotifyPopover(doctor: doctors[0])
                            controller.modalPresentationStyle = .overCurrentContext
                            self.present(controller, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    @objc func startCall (_ notification: NSNotification) {
        if let doctor = notification.userInfo?["doctor"] as? DoctorCard {
            self.navigationController?.pushViewController(CallSettingsInCall(doctor: doctor), animated: true)
        }
    }
    
}

// MARK: List Adaptar Datasource functions

extension DoctorsCollection {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.items as! [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is DoctorCollection: return DoctorSectionController(doctorCollection: self.doctorsCollection)
            default:
                return PageHeaderSectionController(bottomMargin: 55)
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    func listAdapter(_ listAdapter: ListAdapter, move object: Any, from previousObjects: [Any], to objects: [Any]) {
        
    }
    
}

// MARK: Action Handlers

extension DoctorsCollection {
    
    @objc func gotoFAQ() {
        self.navigationController?.pushViewController(FAQList(), animated: true)
        print("go to faq")
    }
}





