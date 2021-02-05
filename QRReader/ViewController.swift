//
//  ViewController.swift
//  QRReader
//
//  Created by mong on 2021/02/03.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
//    var QRReaderView: ReaderView!
    @IBOutlet var QRReaderView: ReaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.QRReaderView.delegate = self
        self.view.addSubview(QRReaderView)
    }
    override func viewDidLayoutSubviews() {
        initQRReaderView(QRReaderView: QRReaderView)
    }

}

private func initQRReaderView(QRReaderView: ReaderView){
    QRReaderView.start()
}

extension ViewController: ReaderViewDelegate {
    func readerComplete(status: ReaderStatus) {
        var title = ""
        var message = ""
        
        switch status {
        case let .success(code):
            print("# Success")
            guard let code = code else {
                title = "error"
                message = "recognize failure"
                break
            }
            title = "success"
            message = code
        case .fail:
            title = "fail"
            message = "recongize failure"
        case let .stop(isButtonTap):
            title = "stop"
            message = "recongize failure"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: {(_) in
            self.QRReaderView.start()
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
