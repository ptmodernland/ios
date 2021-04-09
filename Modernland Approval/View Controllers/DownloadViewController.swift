//
//  DownloadViewController.swift
//  Modernland Approval
//
//  Created by ITMLR-01 on 09/04/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit
import PDFKit

class DownloadViewController: BaseViewController {
    
    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var downloadBar: UIProgressView!

    //*******
    var downloader = Timer()
    var minValue = 0
    var maxValue = 100
    //********

    var namePDF = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        downloadBar.setProgress(0, animated: false)

        if let pdfUrl = URL(string: "https://approval.modernland.co.id/assets/file/\(namePDF)") {


            print(pdfUrl)

            // then lets create your document folder url
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(pdfUrl.lastPathComponent)
            print(destinationUrl)

            // to check if it exists before downloading it
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                print("The file already exists at path")

                /************** show pdf ****************/
                let pdfUrl = destinationUrl.path
                let rutafile = URL(fileURLWithPath: pdfUrl)
                print(pdfUrl)
                if let document = PDFDocument(url: rutafile) {
                    pdfView.autoScales = true
                    pdfView.document = document
                }
                 /************** end show pdf ****************/


                // if the file doesn't exist
            } else {
                 print("file doesn't exist")

                downloadBar.setProgress(0, animated: false)

                // you can use NSURLSession.sharedSession to download the data asynchronously
                URLSession.shared.downloadTask(with: pdfUrl, completionHandler: { (location, response, error) -> Void in
                    guard let location = location, error == nil else { return }
                    do {
                        // after downloading your file you need to move it to your destination url
                        try FileManager.default.moveItem(at: location, to: destinationUrl)
                        print("File moved to documents folder")

                        print("file has already been downloaded")
                        /************** show pdf ****************/
                        let pdfUrl = destinationUrl.path
                        let rutafile = URL(fileURLWithPath: pdfUrl)
                        print(pdfUrl)
                        if let document = PDFDocument(url: rutafile) {
                            self.pdfView.autoScales = true
                            self.pdfView.document = document
                        }
                        /************** show pdf ****************/

                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }).resume()
            }
        }

    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        if totalBytesExpectedToWrite > 0 {
            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)

            self.downloadBar.setProgress(progress, animated: false)
        }
    }
}
