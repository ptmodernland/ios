//
//  Storyboards.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 28/02/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation
import UIKit

internal enum StoryboardScene {
    
    internal enum Login: StoryboardType {
        internal static let storyboardName = "Login"
        
        internal static let loginViewController = SceneType<LoginViewController>(storyboard: Login.self, identifier: "LoginViewController")
    }
    
    internal enum Dashboard: StoryboardType {
        internal static let storyboardName = "Dashboard"
        
        internal static let dashboardViewController = SceneType<DashboardViewController>(storyboard: Dashboard.self, identifier: "DashboardViewController")
    }
    
    internal enum Comparasion: StoryboardType {
        internal static let storyboardName = "Comparasion"

        internal static let ListCompareViewController = SceneType<ListCompareViewController>(storyboard: Comparasion.self, identifier: "ListCompareViewController")
        internal static let DetailCompareViewController = SceneType<DetailCompareViewController>(storyboard: Comparasion.self, identifier: "DetailCompareViewController")
        internal static let ListHistoryCompareViewController = SceneType<ListHistoryCompareViewController>(storyboard: Comparasion.self, identifier: "ListHistoryCompareViewController")
        
    }
    
    internal enum PBJ: StoryboardType {
        internal static let storyboardName = "PBJ"
        
        internal static let listPBJViewController = SceneType<ListPBJViewController>(storyboard: PBJ.self, identifier: "ListPBJViewController")
        
        internal static let detailMenuPBJViewController = SceneType<DetailMenuPBJViewController>(storyboard: PBJ.self, identifier: "DetailMenuPBJViewController")
        
        internal static let listHistoryPBJViewController = SceneType<ListHistoryPBJViewController>(storyboard: PBJ.self, identifier: "ListHistoryPBJViewController")
    }
    
    internal enum IOM: StoryboardType {
        internal static let storyboardName = "IOM"
        
        internal static let listIOMViewController = SceneType<ListIOMViewController>(storyboard: IOM.self, identifier: "ListIOMViewController")
        
        internal static let listHistoryIOMViewController = SceneType<ListHistoryIOMViewController>(storyboard: IOM.self, identifier: "ListHistoryIOMViewController")

        internal static let iOMViewController = SceneType<IOMViewController>(storyboard: IOM.self, identifier: "IOMViewController")
        
        internal static let detailIOMViewController = SceneType<DetailIOMViewController>(storyboard: IOM.self, identifier: "DetailIOMViewController")
        
        internal static let listHeadKoordinasiViewController = SceneType<ListHeadKoordinasiViewController>(storyboard: IOM.self, identifier: "ListHeadKoordinasiViewController")
        
        internal static let listRekomendasiIOMViewController = SceneType<ListRekomendasiIOMViewController>(storyboard: IOM.self, identifier: "ListRekomendasiIOMViewController")
        
        internal static let listCategoryIOMViewController = SceneType<ListCategoryIOMViewController>(storyboard: IOM.self, identifier: "ListCategoryIOMViewController")
        
        internal static let listKategoriIOMViewController = SceneType<ListKategoriIOMViewController>(storyboard: IOM.self, identifier: "ListKategoriIOMViewController")
        
    }
    
    internal enum Setting: StoryboardType {
        internal static let storyboardName = "Setting"
        
        internal static let settingViewController = SceneType<SettingViewController>(storyboard: Setting.self, identifier: "SettingViewController")
        
        internal static let changePasswordViewController = SceneType<ChangePasswordViewController>(storyboard: Setting.self, identifier: "ChangePasswordViewController")
    }
    
    internal enum WebView: StoryboardType {
        internal static let storyboardName = "WebView"
        
        internal static let webViewViewController = SceneType<WebViewViewController>(storyboard: WebView.self, identifier: "WebViewViewController")
    }
}

internal protocol StoryboardType {
    static var storyboardName: String { get }
}

internal extension StoryboardType {
    static var storyboard: UIStoryboard {
        let name = self.storyboardName
        return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
    }
}

internal struct SceneType<T: UIViewController> {
    internal let storyboard: StoryboardType.Type
    internal let identifier: String
    
    internal func instantiate() -> T {
        let identifier = self.identifier
        guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
        }
        return controller
    }
}

internal struct InitialSceneType<T: UIViewController> {
    internal let storyboard: StoryboardType.Type
    
    internal func instantiate() -> T {
        guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
            fatalError("ViewController is not of the expected class \(T.self).")
        }
        return controller
    }
}

private final class BundleToken {}
