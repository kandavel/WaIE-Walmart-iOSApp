//
//  DailyPictureViewController.swift
//  Walmart-WaIE
//
//  Created by kandavel on 02/03/23.
//

import Foundation
import UIKit

final class DailyPictureViewController : BaseViewController {
  
    // MARK: -IbOutlet
    @IBOutlet weak var dailyPicImageView : UIImageView!
    @IBOutlet weak var dailyPickDescriptionView : UITextView!
    @IBOutlet weak  var titleLabel : UILabel!
    
    private let viewModel : DailyPictureVM
    
    init(viewModel: DailyPictureVM) {
        self.viewModel = viewModel
        super.init(nibName: "DailyPictureViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
