//
//  OAuthViewController.swift
//  WeiboSwift
//
//  Created by 周剑峰 on 2017/1/17.
//  Copyright © 2017年 周剑峰. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class OAuthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        prepareWebView()
    }
    
    /// 隐藏授权页面
    @objc fileprivate func back() {
        dismiss(animated: true, completion: nil)
    }
    
    /// 自动输入账号
    @objc fileprivate func autoEnterAccount() {
        webView.stringByEvaluatingJavaScript(from:
            "document.getElementById('userId').value='micfeng@hotmail.com';" +
            "document.getElementById('passwd').value='';")
    }
    
    /// webView
    fileprivate lazy var webView = UIWebView()
    
    /// 指示器
    fileprivate lazy var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
}

// MARK: - 界面设置
extension OAuthViewController {
    
    /// 准备UI
    fileprivate func prepareUI() {
        
        title = "微博授权"
        view.backgroundColor = UIColor.cz_random()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", target: self, action: #selector(back))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充账号", target: self, action: #selector(autoEnterAccount))
        
        view.addSubview(webView)
        view.addSubview(activityIndicator)
        
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
        }
        
    }
    
    /// 加载数据
    fileprivate func prepareWebView() {
        webView.delegate = self
        webView.scrollView.isScrollEnabled = false
        webView.loadRequest(URLRequest(url: URL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(WB_APP_KEY)&redirect_uri=\(WB_REDIRECT_URI)")!))
        
        activityIndicator.startAnimating()
    }
    
}

// MARK: - UIWebViewDelegate
extension OAuthViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if !webView.isLoading {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        // 不是回调地址
        if request.url?.absoluteString.hasPrefix(WB_REDIRECT_URI) == false {
            return true
        }
        
        // 不是授权 就是取消授权
        if request.url?.query?.hasPrefix("code=") == false {
            // dismiss页面
            back()
            return false
        }
        
        // 截取code
        let code = request.url?.query?.substring(from: "code=".endIndex) ?? ""
        print("code = \(code)")
        
        NetworkManager.shared.loadAccessToken(code: code) { (isSuccess) in
            if isSuccess {
                SVProgressHUD.showInfo(withStatus: "登录成功")
                // 发出登录成功通知
                NotificationCenter.default.post(name: NSNotification.Name(USER_LOGIN_SUCCESS_NOTIFICATION), object: nil)
                // 关闭页面
                self.back()
            } else {
                SVProgressHUD.showInfo(withStatus: "网络请求失败")
            }
        }
        
        return false
    }
}
