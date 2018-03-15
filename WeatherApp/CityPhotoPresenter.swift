//
//  CityPhotoPresenter.swift
//  WeatherApp
//
//  Created by Vlad Tufis on 15/03/2018.
//  Copyright © 2018 tufyx. All rights reserved.
//

import Foundation

protocol CityPhotoViewProtocol: class {

    // DEFINE VIEW BEHAVIOUR HERE

}

protocol CityPhotoPresenterProtocol: class {
    
    var view: CityPhotoViewProtocol? { get set }

    // DEFINE PRESENTER BEHAVIOUR HERE

}

class CityPhotoPresenter: CityPhotoPresenterProtocol {
    
    weak var view: CityPhotoViewProtocol?

    var interactor: CityPhotoInteractorProtocol
    var router: CityPhotoRouterProtocol

    init(interactor: CityPhotoInteractorProtocol, router: CityPhotoRouterProtocol) {
        self.interactor = interactor
        self.router = router

        self.interactor.result = self
    }

    // IMPLEMENT PRESENTER BEHAVIOUR HERE

}

extension CityPhotoPresenter: CityPhotoInteractorResultProtocol {
    
    // IMPLEMENT INTERACTOR RESULT BEHAVIOUR HERE

}
