//
//  PEGBUIAsyncImageViewModel.swift
//  PEGBUIKit
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation
import PEGBCore
import UIKit

public class PEGBUIAsyncImageViewModel: NSObject, ViewModel {
    private let fileManager = FileManager.default
    let image: Dynamic<UIImage?> = .init(nil)

    func loadImage(from url: URL) {
        let documentsDirectoryURL = fileManager.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
        if let dir = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false),
           let image = UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(url.lastPathComponent).path) {
            self.image.value = image
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            printLog(response?.suggestedFilename ?? url.lastPathComponent)
            printLog("Download Finished")
            do {
                try data.write(to: documentsDirectoryURL.appendingPathComponent(url.lastPathComponent))
            } catch {
                printLog(error.localizedDescription)
            }
            // always update the UI from the main thread
            DispatchQueue.main.async { [weak self] in
                self?.image.value = UIImage(data: data)
            }
        }
        .resume()
    }
}
