//
//  CameraGlobals.swift
//  ALCameraViewController
//
//  Created by Alex Littlejohn on 2016/02/16.
//  Copyright © 2016 zero. All rights reserved.
//
//  Modified by Kevin Kieffer on 2019/08/06.  Changes as follows:
//  Adding adjustable number of columns for library view, based on .ipad or smaller device



import UIKit
import AVFoundation

internal let itemSpacing: CGFloat = 1
internal let scale = UIScreen.main.scale

public class CameraGlobals {
    public static let shared = CameraGlobals()
    
    public var bundle = Bundle(for: CameraViewController.self)
    public var stringsTable = "CameraView"
    public var defaultCameraPosition = AVCaptureDevice.Position.back
    
    public static let MAX_COLUMNS : Int = {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return 20
        default:
            return 10
        }
    }()
    
    public static let MIN_COLUMNS = 2
    
    public static let DEFAULT_COLUMNS : Int = {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return 8
        default:
            return 4
        }
    }()
    
      
    public func photoLibraryThumbnailSize(withColumns columns : Int) -> CGSize {
        
        let cols = CGFloat(columns)
        let thumbnailDimension = (UIScreen.main.bounds.width - ((cols * itemSpacing) - itemSpacing))/cols
        return CGSize(width: thumbnailDimension, height: thumbnailDimension)
            
        
    }
    
}

public struct CameraImages {
    public static var shared = CameraImages()

    public var camera: UIImage // 80 x 80 px
    public var cameraHighlighted: UIImage // 80 x 80 px
    public var close: UIImage //  44 x 44 px
    public var confirm: UIImage //  44 x 44 px
    public var flashAuto: UIImage //  44 x 44 px
    public var flashOff: UIImage //  44 x 44 px
    public var flashOn: UIImage //  44 x 44 px
    public var library: UIImage //  44 x 44 px
    public var libraryCancel: UIImage //  32 x 32 px
    public var libraryConfirm: UIImage //  32 x 32 px
    public var permissions: UIImage // 60 x 60 px
    public var placeholder: UIImage // 104 x 104 px
    public var retake: UIImage //  44 x 44 px
    public var swap: UIImage //  44 x 44 px
    
    public init(camera: UIImage = UIImage(named: "cameraButton", in: CameraGlobals.shared.bundle, compatibleWith: nil)!,
                cameraHighlighted: UIImage = UIImage(named: "cameraButtonHighlighted", in: CameraGlobals.shared.bundle, compatibleWith: nil)!,
                close: UIImage = UIImage(named: "closeButton", in: CameraGlobals.shared.bundle, compatibleWith: nil)!,
                confirm: UIImage = UIImage(named: "confirmButton", in: CameraGlobals.shared.bundle, compatibleWith: nil)!,
                flashAuto: UIImage = UIImage(named: "flashAutoIcon", in: CameraGlobals.shared.bundle, compatibleWith: nil)!,
                flashOff: UIImage = UIImage(named: "flashOffIcon", in: CameraGlobals.shared.bundle, compatibleWith: nil)!,
                flashOn: UIImage = UIImage(named: "flashOnIcon", in: CameraGlobals.shared.bundle, compatibleWith: nil)!,
                library: UIImage = UIImage(named: "libraryButton", in: CameraGlobals.shared.bundle, compatibleWith: nil)!,
                libraryCancel: UIImage = UIImage(named: "libraryCancel", in: CameraGlobals.shared.bundle, compatibleWith: nil)!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                libraryConfirm: UIImage = UIImage(named: "libraryConfirm", in: CameraGlobals.shared.bundle, compatibleWith: nil)!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                permissions: UIImage = UIImage(named: "permissionsIcon", in: CameraGlobals.shared.bundle, compatibleWith: nil)!,
                placeholder: UIImage = UIImage(named: "placeholder", in: CameraGlobals.shared.bundle, compatibleWith: nil)!,
                retake: UIImage = UIImage(named: "retakeButton", in: CameraGlobals.shared.bundle, compatibleWith: nil)!,
                swap: UIImage = UIImage(named: "swapButton", in: CameraGlobals.shared.bundle, compatibleWith: nil)!) {
        self.camera = camera
        self.cameraHighlighted = cameraHighlighted
        self.close = close
        self.confirm = confirm
        self.flashAuto = flashAuto
        self.flashOff = flashOff
        self.flashOn = flashOn
        self.library = library
        self.libraryCancel = libraryCancel
        self.libraryConfirm = libraryConfirm
        self.permissions = permissions
        self.placeholder = placeholder
        self.retake = retake
        self.swap = swap
    }
}
