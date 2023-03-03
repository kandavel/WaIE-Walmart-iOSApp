//
//  DailyPicCoordinator.swift
//  Walmart-WaIE
//
//  Created by kandavel on 03/03/23.
//

import Foundation

protocol DailyPicCoordinatorProtocol : AnyObject {
    
}

final class DailyPicCoordinator {
    
    static func openDailyPicOfTheDayScreen() -> DailyPictureViewController {
        let vm  = DailyPictureVM(webservice: DailyPicService())
        let view = DailyPictureViewController(viewModel: vm)
        return view
    }
}

extension DailyPicCoordinator : DailyPicCoordinatorProtocol {
    
}
