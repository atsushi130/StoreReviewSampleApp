//
//  ViewController.swift
//  StoreReviewSampleApp
//
//  Created by Atsushi Miyake on 2020/11/06.
//

import UIKit
import StoreKit

final class ViewController: UIViewController {

    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.commonInit()
        self.showReviewInApp()
    }

    private func commonInit() {
        self.configureButton()
    }

    private func configureButton() {
        self.view.addSubview(self.button)
        // appearance
        self.button.layer.cornerRadius = 5
        self.button.layer.masksToBounds = true
        self.button.backgroundColor = .darkGray
        // layout
        self.button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.button.heightAnchor.constraint(equalToConstant: 50),
            self.button.widthAnchor.constraint(equalToConstant: 200),
            self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])

        // datasource
        self.button.setTitle("レビューする", for: .normal)
        self.button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        self.writeReview()
    }

    private func showReviewInApp() {
        if #available(iOS 14, *) {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else {
            SKStoreReviewController.requestReview()
        }
    }

    private func writeReview() {
        let baseURLString = "itms-apps://itunes.apple.com//jp/app"
        let id = "id640415578"
        let queryString = "mt=8&action=write-review"
        guard let url = URL(string: "\(baseURLString)/\(id)?\(queryString)") else {
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
}

