//
//  PermissionRequestViewModel.swift
//  Run
//
//  Created by Douglas Taquary on 15/04/18.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

public protocol PermissionRequestViewModelProtocol {
    var steps: [ImageTextViewModelProtocol] { get }
    var title: NSAttributedString { get }
    var okTitle: String { get }
    var didTapOkAction: () -> Void { get }
}

public struct PermissionRequestViewModel: PermissionRequestViewModelProtocol {
    
    public let title: NSAttributedString
    public let okTitle: String
    public let flexibleHeight: Bool
    
    public let steps: [ImageTextViewModelProtocol]
    
    public let didTapOkAction: () -> Void
    
}

extension PermissionRequestViewModel {
    
    public init() {
        self.init(didTapOkAction: { print("Ok") })
    }
    
    public init(didTapOkAction: @escaping () -> Void) {
        let style: StyleProvider = Style()
        
        title = NSAttributedString(string: "Run precisa de acesso ao App Saúde para salvar seus progressos",//Localization.permissionTitle,
                                   font: style.title2,
                                   color: style.textColor)
        flexibleHeight = false
        
        steps = PermissionRequestViewModel.buildSteps()

        okTitle = "Ok"//Localization.authorizationOkButton
        
        self.didTapOkAction = didTapOkAction
    }
    
    
    static func buildSteps() -> [ImageTextViewModelProtocol] {
        struct Step: ImageTextViewModelProtocol {
            let image: UIImage?
            let text: NSAttributedString?
        }
        
        let style = Style()
        let font = style.subhead
        let color = style.textColor
        
        let configs = [(#imageLiteral(resourceName: "ic-settings"), "Vá Ajustes"),
                       (#imageLiteral(resourceName: "bot"), "Entre em Privacidade"),
                       (#imageLiteral(resourceName: "ic-health"), "Entre em saúde"),
                       (#imageLiteral(resourceName: "ic-run"), "Entre em Run e permita que escreva e leia dados")]
        
        let steps = configs.map { (image, string) -> Step in
            return Step(image: image,
                        text: NSAttributedString(string: string,
                                                 font: font,
                                                 color: color))
        }
        
        return steps
    }
    
}
    

