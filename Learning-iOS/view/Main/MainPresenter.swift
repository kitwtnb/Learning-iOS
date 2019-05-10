//
// Created by Keita Watanabe on 2019-05-07.
// Copyright (c) 2019 Keita Watanabe. All rights reserved.
//

class MainPresenter {
    weak var view: MainView? = nil
    let segues = [
        "Scene change",
        "Counter",
        "Navigation with parameter",
        "Camera",
        "Camera roll",
        "Web API access",
        "Realm sample"
    ]

    func didSelectRowAt(_ index: Int) {
        view?.navigateTo(segues[index])
    }
}
