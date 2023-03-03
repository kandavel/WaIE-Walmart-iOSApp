//
//  DailyPictureViewController.swift
//  Walmart-WaIE
//
//  Created by kandavel on 02/03/23.
//

import Foundation
import UIKit

protocol DailyPictureViewControllerProtocol : AnyObject {
    func updateLabel(title : String?,explanantion : String?)
    func updateImage(image : UIImage?)
    func showLoader()
    func hideLoader()
    func showToastMessage(message : String)
    func showDefaultStateWhenNoInternet(message : String,defaultImage : String)
}

final class DailyPictureViewController : BaseViewController {
  
    // MARK: -IbOutlet
    @IBOutlet weak var dailyPicImageView : UIImageView!
    @IBOutlet weak var dailyPickDescriptionView : UITextView!
    @IBOutlet weak  var titleLabel : UILabel!
    
    private var viewModel : DailyPictureVMProtocol
    private var animator: UIViewPropertyAnimator?
    
    init(viewModel: DailyPictureVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: DailyPictureViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.setDelegate(delelgate: self)
        self.viewModel.viewDidLoad()
    }
    
    fileprivate func addGestureRecognizer() {
        let tapGesture  =  UITapGestureRecognizer(target: self, action: #selector(moveToDetaiScreen))
        tapGesture.numberOfTapsRequired =  1
        self.dailyPicImageView.isUserInteractionEnabled = true
        self.dailyPicImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func moveToDetaiScreen() {
        
    }
    
    private func showImage(image: UIImage?) {
        dailyPicImageView.alpha = 0.0
        animator?.stopAnimation(false)
        dailyPicImageView.image = image
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
            self.dailyPicImageView.alpha = 1.0
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    deinit {
        print("View Controller \(String(describing: DailyPictureViewController.self)) is deallocated")
    }
}

extension DailyPictureViewController : DailyPictureViewControllerProtocol {
    func showDefaultStateWhenNoInternet(message: String, defaultImage: String) {
        
    }
    
    func showDefaultStateWhenNoInternetI() {
        
    }
    
    func showLoader() {
        self.showLoading()
    }
    
    func hideLoader() {
        self.hideLoading()
    }
    
    func showToastMessage(message: String) {
        
    }
    
    func updateLabel(title: String?, explanantion: String?) {
        self.title  =  title
        self.dailyPickDescriptionView.text  = explanantion
    }
    
    func updateImage(image: UIImage?) {
        self.dailyPicImageView.image  = image
    }
}
