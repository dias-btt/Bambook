//
//  ReadViewController.swift
//  Bambook
//
//  Created by Диас Сайынов on 24.01.2024.
//

import UIKit
import PDFKit

class ReadViewController: UIViewController, ReadViewProtocol {
    var presenter: ReadPresenterProtocol?

    let pdfView = PDFView()

    // Loading view
    private let loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // Custom loading animation: jumping gear image
    private let loadingImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bambook_logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Add loading view
        view.addSubview(loadingView)
        loadingView.addSubview(loadingImageView)

        // Set up constraints for the loading view and loading image view
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loadingImageView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            loadingImageView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            loadingImageView.heightAnchor.constraint(equalToConstant: 90),
            loadingImageView.widthAnchor.constraint(equalToConstant: 190)// Adjust height as needed
        ])

        // Load PDF document in the background
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let url = URL(string: "https://canonburyprimaryschool.co.uk/wp-content/uploads/2016/01/Joanne-K.-Rowling-Harry-Potter-Book-1-Harry-Potter-and-the-Philosophers-Stone-EnglishOnlineClub.com_.pdf"),
                  let document = PDFDocument(url: url) else {
                return
            }

            DispatchQueue.main.async { [weak self] in
                // Remove loading view
                self?.loadingView.removeFromSuperview()

                // Update UI on the main thread
                self?.pdfView.document = document
                self?.pdfView.frame = self?.view.bounds ?? CGRect.zero
                self?.view.addSubview(self?.pdfView ?? UIView())
            }
        }

        // Start the custom loading animation
        startCustomLoadingAnimation()
    }

    private func startCustomLoadingAnimation() {
        let jumpDuration: TimeInterval = 0.5
        let jumpHeight: CGFloat = 20.0

        UIView.animate(withDuration: jumpDuration, animations: { [weak self] in
            self?.loadingImageView.transform = CGAffineTransform(translationX: CGFloat.random(in: -jumpHeight...jumpHeight),
                                                                  y: CGFloat.random(in: -jumpHeight...jumpHeight))
        }) { [weak self] _ in
            // Recursively call the animation
            self?.startCustomLoadingAnimation()
        }
    }
}

