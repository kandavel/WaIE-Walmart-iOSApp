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
    let userDafaults  =  UserDataProvider()
    
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
            case .failure(let error):
                self?.view?.hideLoader()
                self?.handleErrorCases(error: error)
                break
            }
        }
    }
    
    fileprivate func updateUI() {
        updateLastSeenAPODData()
        loadImage(url: self.picture?.url)
        updateTitleAndExplanation()
        self.view?.hideLoader()
    }
    
    fileprivate func setData(picture : Picture?) {
        self.picture  = picture
    }
    
    func updateLastSeenAPODData() {
        userDafaults.setUserVisitedCount()
        userDafaults.setapodTitle(title: self.picture?.title)
        userDafaults.setapodExplanantion(explanantion: self.picture?.explanation)
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
                self.userDafaults.setLastSeenImageUrl(data: downloadedImage.pngData())
                self.view?.updateImage(image: downloadedImage)
            }
        }
    }
    
    func checkUserVisitedAPODPage() {
        let count  = userDafaults.getUserVisitedCount()
        if count > 0  {
            if let data  = userDafaults.getLastSeenImageUrl(),let image =  UIImage(data: data) {
                self.view?.updateImage(image: image)
            }
            if let title = userDafaults.getapodTitle(),let explanantion  = userDafaults.getapodExplanantion() {
                self.view?.updateLabel(title: title, explanantion: explanantion)
            }
        }
        else {
           //this scenario is not handled
        }
        self.view?.showToastMessage(message: "We are not connected to the internet, showing you the last image we have.")
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
        case .responseError( _):
            break
        case .parserError(_):
            break
        case .reachabilityError(_):
            checkUserVisitedAPODPage()
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
