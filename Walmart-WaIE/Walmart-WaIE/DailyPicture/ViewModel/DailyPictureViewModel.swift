//
//  DailyPictureViewModel.swift
//  Walmart-WaIE
//
//  Created by kandavel on 02/03/23.
//

import Foundation
import UIKit

protocol DailyPictureVMProtocol: AnyObject {
    func viewDidLoad()
    func setDelegate(delelgate : DailyPictureViewControllerProtocol)
}

final class DailyPictureVM {
    
    let webservice : DailyPicService
    private (set)var picture : Picture?
    private var isLoading: Bool
    weak var view : DailyPictureViewControllerProtocol?
    
    
    init(webservice : DailyPicService) {
        self.webservice  = webservice
        self.isLoading  = false
    }
    
    func fetchDailyPics() {
        self.view?.showLoader()
        let endpoint  = DailyPicServiceEndPoint.getDailyPicture(name: "")
        self.webservice.fetchDailyPictures(endpoint) { [weak self] (result) in
            self?.parseResults(result: result)
        }
    }
    
    func parseResults(result : PictureResult) {
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success(let picture):
                self?.setData(picture: picture)
                self?.updateUI()
                break
            case .failure(_):
                break
            }
        }
    }
    
    fileprivate func updateUI() {
        loadImage(url: self.picture?.url)
        updateTitleAndExplanation()
        self.view?.hideLoader()
    }
    
    fileprivate func setData(picture : Picture?) {
        self.picture  = picture
    }
    
    func updateTitleAndExplanation() {
        self.view?.updateLabel(title: self.picture?.title, explanantion: self.picture?.explanation)
    }
    
    fileprivate func loadImage(url : String?) {
        guard let imageUrl =  url,let url  = URL(string: imageUrl) else {
            return
        }
        ImageLoader.shared.loadImage(from: url) { image, error in
            if let downloadedImage  = image {
                self.view?.updateImage(image: downloadedImage)
            }
        }
            
    }
    
    func handleErrorCases(error : NetworkError) {
        switch error {
        case .invalidRequest:
            break
        case .dataMissing:
            break
        case .endpointNotMocked:
            break
        case .mockDataMissing:
            break
        case .responseError(let error):
            break
        case .parserError(let error):
            break
        case .reachabilityError(let error):
            break
        }
    }
}

extension DailyPictureVM : DailyPictureVMProtocol {
    func setDelegate(delelgate : DailyPictureViewControllerProtocol) {
        self.view = delelgate
    }
    
    func viewDidLoad() {
        self.fetchDailyPics()
    }
}
