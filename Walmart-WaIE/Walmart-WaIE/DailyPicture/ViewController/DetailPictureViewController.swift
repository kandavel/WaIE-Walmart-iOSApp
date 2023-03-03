//
//  DetailPictureViewController.swift
//  Walmart-WaIE
//
//  Created by kandavel on 04/03/23.
//

import Foundation
import UIKit
final class  DetailPictureViewController : BaseViewController {
    
    // MARK: -IbOutlet
    @IBOutlet weak var zoomedImageView : UIImageView!
    private var image : UIImage
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: String(describing: DetailPictureViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.zoomedImageView.image = self.image
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
