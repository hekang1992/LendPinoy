//
//  LPHFView.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/7.
//

import UIKit
import WebKit
import StoreKit

class LPHFView: LPJCView {
    
    lazy var navView: LPNavgationView = {
        let navView = LPNavgationView()
        return navView
    }()
    
    var guanbiBlock: (() -> Void)?
    
    var bugPointBlock: ((String, String) -> Void)?
    
    var qunaliUrlBlock: ((String) -> Void)?
    
    lazy var hwView: WKWebView = {
        let conf = WKWebViewConfiguration()
        let usercc = WKUserContentController()
        let jsfangfa = ["contemplating", "seemed", "lacquer", "slightly", "connected", "surname"]
        jsfangfa.forEach { usercc.add(self, name: $0) }
        conf.userContentController = usercc
        let hwView = WKWebView(frame: .zero, configuration: conf)
        hwView.translatesAutoresizingMaskIntoConstraints = false
        hwView.scrollView.bounces = false
        hwView.scrollView.alwaysBounceVertical = false
        hwView.scrollView.contentInsetAdjustmentBehavior = .never
        hwView.scrollView.showsVerticalScrollIndicator = false
        hwView.scrollView.showsHorizontalScrollIndicator = false
        hwView.navigationDelegate = self
        hwView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        return hwView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(navView)
        addSubview(hwView)
        makeui()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("-------------")
    }
    
}

extension LPHFView: WKScriptMessageHandler, WKNavigationDelegate {
    
    func makeui() {
        navView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusManager.statusBarHeight + 5.lpix())
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(44.lpix())
        }
        hwView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(navView.snp.bottom)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.title) {
            if let biaoti = change?[.newKey] as? String {
                DispatchQueue.main.async { [weak self] in
                    self?.navView.titleLabel.text = biaoti
                }
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let method = methodMapping[message.name] else {
            print("Unknown method: \(message.name)")
            return
        }
    }
    
    private var methodMapping: [String: ([String]?) -> Void] {
        return [
            "lacquer": { url in
                self.dadianhua(url)
            },
            "contemplating": { url in
                self.bugpoing(url)
            },
            "seemed": { url in
                self.daikaiwangzhi(url)
            },
            "slightly": { _ in self.closeyemian() },
            "surname": { _ in self.paimingduoshaone() },
            "toEscape": { _ in self.toHome() }
        ]
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        ViewCycleManager.addCycView()
        guard let hfdzUlr = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        let urlStr = hfdzUlr.absoluteString
        if urlStr.hasPrefix("whatsapp:") || urlStr.hasPrefix("mailto:") {
            if UIApplication.shared.canOpenURL(hfdzUlr) {
                UIApplication.shared.open(hfdzUlr, options: [:], completionHandler: nil)
            } else if urlStr.hasPrefix("whatsapp:") {
                ToastUtility.showToast(message: "Please install WhatsApp to proceed")
            }
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        ViewCycleManager.addCycView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            ViewCycleManager.hideCycView()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ViewCycleManager.hideCycView()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ViewCycleManager.hideCycView()
    }
    
    private func closeyemian() {
        self.guanbiBlock?()
    }
    
    private func toHome() {
        NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC_NOTI), object: nil, userInfo: ["guest": "0"])
    }
    
    private func dadianhua(_ arguments: [String]?) {
        guard let leixingzifu = arguments?.first else { return }
        if leixingzifu.hasPrefix("LendPinoy://") {
            if let range = leixingzifu.range(of: "LendPinoy://") {
                let value = String(leixingzifu[range.upperBound...])
                if value.isNumeric {
                    let phoneStr = "telprompt://\(value)"
                    if let phoneURL = URL(string: phoneStr), UIApplication.shared.canOpenURL(phoneURL) {
                        UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                    }
                } else {
                    let mobileStr = UserDefaults.standard.string(forKey: LP_LOGIN) ?? ""
                    let phoneStr = "LendPinoy: \(mobileStr)"
                    let emailBody = phoneStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                    
                    if let emailURL = URL(string: "mailto:\(value)?body=\(emailBody)"), UIApplication.shared.canOpenURL(emailURL) {
                        UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
                    }
                }
            }
        }
        
    }
    
    private func paimingduoshaone() {
        if #available(iOS 14.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else {
            SKStoreReviewController.requestReview()
        }
    }
    
    private func bugpoing(_ arguments: [String]?) {
        guard let productId = arguments?.first, arguments?.count ?? 0 >= 2 else { return }
        let startTime = arguments![1]
        self.bugPointBlock?(productId, startTime)
        
    }
    
    private func daikaiwangzhi(_ arguments: [String]?) {
        guard let path = arguments?.first else { return }
        self.qunaliUrlBlock?(path)
    }
    
}

extension String {
    var isNumeric: Bool {
        return !isEmpty && allSatisfy { $0.isNumber }
    }
}
