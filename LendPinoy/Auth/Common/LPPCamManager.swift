//
//  LPPCamManager.swift
//  LendPinoy
//
//  Created by Andrew on 2024/9/5.
//

import UIKit
import Photos
import RxSwift
import AVFoundation

class LPPCamManager: NSObject {
    
    static let shared = LPPCamManager()
    
    private let disposeBag = DisposeBag()
    
    private override init() {
        super.init()
    }
    
    func checkPhotoLibraryPermissions() -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            let status = PHPhotoLibrary.authorizationStatus()
            switch status {
            case .authorized:
                observer.onNext(true)
                observer.onCompleted()
            case .limited, .restricted, .denied:
                observer.onNext(false)
                observer.onCompleted()
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization { newStatus in
                    observer.onNext(newStatus == .authorized)
                    observer.onCompleted()
                }
            @unknown default:
                observer.onNext(false)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func checkCameraPermissions() -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            switch status {
            case .authorized:
                observer.onNext(true)
                observer.onCompleted()
            case .restricted, .denied:
                observer.onNext(false)
                observer.onCompleted()
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    observer.onNext(granted)
                    observer.onCompleted()
                }
            @unknown default:
                observer.onNext(false)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func presentPhoto(from viewController: UIViewController) {
        checkPhotoLibraryPermissions()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] granted in
                guard granted else {
                    self?.showAlert(from: viewController, for: "Photo Album")
                    return
                }
                self?.showImagePicker(from: viewController, sourceType: .photoLibrary, isFront: false)
            })
            .disposed(by: disposeBag)
    }
    
    func presentCamera(from viewController: UIViewController, isFront: Bool) {
        checkCameraPermissions()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] granted in
                guard granted else {
                    self?.showAlert(from: viewController, for: "Camera")
                    return
                }
                self?.showImagePicker(from: viewController, sourceType: .camera, isFront: isFront)
            })
            .disposed(by: disposeBag)
    }
    
    private func showImagePicker(from viewController: UIViewController, sourceType: UIImagePickerController.SourceType, isFront: Bool) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        if sourceType == .camera {
            imagePicker.cameraDevice = isFront ? .front : .rear
            if isFront {
                DispatchQueue.main.async {
                    self.hideButton(in: imagePicker.view)
                }
            }
        }
        imagePicker.delegate = viewController as? (UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        imagePicker.modalPresentationStyle = .fullScreen
        viewController.present(imagePicker, animated: true, completion: nil)
    }
    
    private func showAlert(from vc: UIViewController, for feature: String) {
        let alert = UIAlertController(
            title: "\(feature) Access Disabled",
            message: "Please enable \(feature) access in settings to use this feature.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        })
        vc.present(alert, animated: true, completion: nil)
    }
    
    private func hideButton(in view: UIView) {
        view.subviews.forEach { subview in
            if let button = subview as? UIButton, button.description.contains("CAMFlipButton") {
                button.isHidden = true
                return
            }
            hideButton(in: subview)
        }
    }
    
}
