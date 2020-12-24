//
//  ViewController.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/27/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import UIKit
import Alamofire

class OnBoardingCollection: HugoMedUICollectionViewController {
    
    let cell_id = "boarding"
    
    var currentPage = 0
    
    
    let content = [
        OnBoarding(photo: "onboarding-med01", title: String.scanFor(key: .welcome_title_1), description: String.scanFor(key: .welcome_message_1)),
        OnBoarding(photo: "onboarding-med02", title: String.scanFor(key: .welcome_title_2), description: String.scanFor(key: .welcome_message_2)),
        OnBoarding(photo: "onboarding-med03", title: String.scanFor(key: .welcome_title_3), description: String.scanFor(key: .welcome_message_3))
    ]
    
    lazy var bottomControlsStackView: UIStackView =  {
        let sc = UIStackView(arrangedSubviews: [button, bottomDescription])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.axis = .vertical
        sc.distribution = .equalSpacing
        sc.spacing = 20
        return sc
    }()
    
    lazy var pageControl: UIStackView = {
        let img1 = UIImageView.photo(name: "active")
        let img2 = UIImageView.photo(name: "inactive")
        let img3 = UIImageView.photo(name: "inactive")
        let pc = UIStackView(arrangedSubviews: [img1, img2, img3])
        pc.updateImageViewAt(index: 0)
        pc.axis = .horizontal
        pc.distribution = .equalSpacing
        pc.spacing = 5
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    
    
    lazy var button: UIButton = {
        let buttonContent = String.scanFor(key: ContentKeys.welcome_button)
        let button = UIButton.mainButton(text: NSMutableAttributedString(string: buttonContent.text ?? "", attributes: [NSAttributedString.Key.font: buttonContent.getFont(), NSAttributedString.Key.foregroundColor: buttonContent.getTextColor()]), radius: CGFloat(buttonContent.getRadius()), backGroundColor: buttonContent.getBackgroundColor())
        button.addTarget(self, action: #selector(gotoDoctorViewController), for: .touchUpInside)
        return button
    }()

    lazy var bottomDescription: UITextView = {
        let textView = UITextView.textView()
        let bottomContent = String.scanFor(key: ContentKeys.welcome_sub_message_3)
        textView.attributedText = bottomContent.getAttributedText(alignment: .center)
        return textView
    }()
    
    lazy var constraints1 =  [
           pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
           pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
    ]
    lazy var constraints3 =  [
           pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
           pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
    ]
    lazy var constraints2 =  [
        bottomControlsStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -55),
        bottomControlsStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
        bottomControlsStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        pageControl.bottomAnchor.constraint(equalTo: bottomControlsStackView.topAnchor, constant: -20),
        //button.bottomAnchor.constraint(equalTo: self.bottomControlsStackView.bottomAnchor, constant: -50),
        button.heightAnchor.constraint(equalToConstant: 44),
        button.widthAnchor.constraint(equalTo: self.bottomControlsStackView.widthAnchor),
    ]
    lazy var constraints4 =  [
        bottomControlsStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -55),
        bottomControlsStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
        bottomControlsStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        pageControl.bottomAnchor.constraint(equalTo: bottomControlsStackView.topAnchor, constant: -20),
        //button.bottomAnchor.constraint(equalTo: self.bottomControlsStackView.bottomAnchor, constant: -50),
        button.heightAnchor.constraint(equalToConstant: 44),
        button.widthAnchor.constraint(equalTo: self.bottomControlsStackView.widthAnchor),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarColor = .white
        navBarTintColor = String.scanFor(key: .nav_bar).getTextColor()
        navBarTitle = nil
        navBarTitleImage = "hugo-logo"
        // Do any additional setup after loading the view.
        setupLayout()
        
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.register(OnBoardingCollectionCell.self, forCellWithReuseIdentifier: cell_id)
        
        APIRequests.shared.delegate = self
        _ = APIRequests.shared.fetch(url: MED_API_URL.GET_PATIENT_BY_ID(497))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil
        super.viewWillAppear(true)
    }
    
    fileprivate func setupLayout() {
        view.addSubview(pageControl)
        view.addSubview(bottomControlsStackView)
        setConstraints(constraints: constraints1)
    }
    
    func setConstraints(constraints: [NSLayoutConstraint]) {
        self.view.addConstraints(constraints)
    }
    
    func removeConstraints() {
        self.view.removeConstraints(constraints1)
        self.view.removeConstraints(constraints2)
        self.view.removeConstraints(constraints3)
        self.view.removeConstraints(constraints4)
    }
    
    @objc func gotoDoctorViewController() {
        let controller = UINavigationController(rootViewController: DoctorsCollection())
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
   
}

extension OnBoardingCollection: NetworkStatus {
    
    func completed() {
    }
    
    func success(response: Data) throws {
//        guard let response = response else {
//            throw AppErrors.NoResponse
//        }
        let decoder = JSONDecoder()
        switch APIRequests.shared.current_api_url {
            case .GET_PATIENT_BY_ID(_):
                guard let patients = try? decoder.decode([Patient].self, from: response), patients.count > 0 else {
                    throw AppErrors.PatientNotSet
                }
                AppData.shared.setPatient(patients[0])
                if let country_id = AppData.shared.current_patient?.country_id {
                    _ = APIRequests.shared.fetch(url: MED_API_URL.GET_COMPANY_CATALOG(country_id))
                }
            case .GET_COMPANY_CATALOG(_):
                guard let companies = try? decoder.decode([Company].self, from: response), companies.count > 0 else {
                    throw AppErrors.CompaniesNotFound
                }
                AppData.shared.setCompanies(companies)
                print("\(String(describing: AppData.shared.microuniverse_company_id))")
            default:
                print("error")
        }        
    }
    
    func started() {
        
    }
    
    func progress(progress: Double) {
        
    }
    
    func error(error: AFError?) {
        print("error: \(String(describing: error))")
    }
}

extension OnBoardingCollection: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentPage = indexPath.item
        pageControl.updateImageViewAt(index: indexPath.item)
        self.removeConstraints()
        if indexPath.item == 2 {
            if (self.view.frame.size.width > self.view.frame.size.height) {
                setConstraints(constraints: constraints4)
            }
            else {
                setConstraints(constraints: constraints2)
            }
            bottomControlsStackView.isHidden = false
        }
        else {
            if (self.view.frame.size.width > self.view.frame.size.height) {
                setConstraints(constraints: constraints3)
            }
            else {
                setConstraints(constraints: constraints1)
            }
            bottomControlsStackView.isHidden = true
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height) }

    override func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { content.count }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets { .zero }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if let cell = collectionView.dequeueReusableCell(withReuseIdentifier:cell_id, for: indexPath) as? OnBoardingCollectionCell {
           cell.index = indexPath.item
           cell.data = content[indexPath.item]
           return cell
       }
       return OnBoardingCollectionCell()
    }
}


extension OnBoardingCollection {
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        self.currentPage = Int(x / view.frame.width)
        pageControl.updateImageViewAt(index: self.currentPage)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        pageControl.updateImageViewAt(index: self.currentPage)
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionView.reloadData()
            
            if self.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                
            }

        }) { (_) in

        }
    }
}

class OnBoardingCollectionCell: UICollectionViewCell, NSLayoutManagerDelegate {
    var index: Int? 
    var data: OnBoarding? {
        didSet {
            guard let data = data else { return }
            self.mainPhoto.image = UIImage(named: data.photo)
           // self.mainPhoto.layer.borderColor = UIColor.orange.cgColor
            //self.mainPhoto.layer.borderWidth = 2
            self.titleTextView.text = data.titleContent.text
            self.titleTextView.font = data.titleContent.getFont()
            //self.titleTextView.layer.borderColor = UIColor.orange.cgColor
           // self.titleTextView.layer.borderWidth = 2
            self.titleTextView.textColor = data.titleContent.getTextColor()
            self.descriptionTextView.attributedText = data.descriptionContent.getAttributedText(alignment: .center)
            //self.descriptionTextView.setNeedsLayout()
            
            self.removeConstraints(self.constraints1)
            self.removeConstraints(self.constraints2)
            self.removeConstraints(self.constraints3)
            if self.frame.size.width > self.frame.size.height {
                content.distribution = .fillProportionally
                if index == 2 && self.frame.size.width > self.frame.size.height {
                    setConstraints(constraints: self.constraints3)
                }
                else {
                    setConstraints(constraints: self.constraints2)
                }
                
            }
            else {
                content.distribution = .fill
                setConstraints(constraints: self.constraints1)
            }
        }
    }
    private let mainPhoto = UIImageView.photo()
    private let titleTextView = UITextView.textView()
    private let descriptionTextView = UITextView.textView()
    
    lazy var constraints1 = [
        self.content.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        self.content.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
        self.content.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -159),
        self.content.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -55)
    ]
    
    lazy var constraints3 = [
        self.content.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        self.content.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
        self.content.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -139),
        self.content.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -55),
        //self.titleTextView.heightAnchor.constraint(equalToConstant: <#T##CGFloat#>)
    ]
    
    lazy var constraints2 = [
        self.content.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        self.content.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
        self.content.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -39),
        self.content.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -55),
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLayout()
    }
    
    
    
    lazy private var content: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [self.mainPhoto, self.titleTextView, self.descriptionTextView])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fillProportionally
        return stackview
    }()
    
    func setConstraints(constraints: [NSLayoutConstraint]) {
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupLayout() {
        addSubview(content)
        self.titleTextView.layoutManager.delegate = self
        self.descriptionTextView.layoutManager.delegate = self
    }
    
    func layoutManager(_ layoutManager: NSLayoutManager, lineSpacingAfterGlyphAt glyphIndex: Int, withProposedLineFragmentRect rect: CGRect) -> CGFloat {
        if self.frame.size.width > self.frame.size.height {
            return 44
        }
        return 0
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
