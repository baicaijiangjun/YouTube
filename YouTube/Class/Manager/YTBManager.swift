//
//  YTBManager.swift
//  YouTube
//
//  Created by Turbo on 2020/5/28.
//  Copyright © 2020 turbo. All rights reserved.
//

import UIKit

class YTBManager: NSObject {
    static let shared = YTBManager()
    var vedioPlayState: Int!
    
    private override init() {
        super.init()
        self.vedioPlayState = VedioPlayState.closed.rawValue
        HostReach().reachabilityForInternetConnection()
    }
}
