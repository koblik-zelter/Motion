//
//  VideoListViewController.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 02.08.2022.
//

import UIKit

protocol VideoListViewControllerDelegate: AnyObject {
    func videoListViewControllerDidSelectVideo(_ sender: UIViewController, title: String, urlString: String)
}

protocol VideoListViewProtocol: AnyObject {
    func showLoading(_ isLoading: Bool)
    func reloadData()
    func showError()
}

final class VideoListViewController: UIViewController {

    private lazy var tableView = UITableView()
    private lazy var loadingIndicator = UIActivityIndicatorView()

    private let presenter: VideoListPresenterProtocol
    private let dispatcher: Dispatcher
    private weak var delegate: VideoListViewControllerDelegate?

    init(presenter: VideoListPresenterProtocol,
         delegate: VideoListViewControllerDelegate,
         dispatcher: Dispatcher = DispatchQueue.main) {
        self.presenter = presenter
        self.dispatcher = dispatcher
        self.delegate = delegate

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.viewDidLoad(self)
    }

    private func setupViews() {
        title = LocalizedString.VideoList.title
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(tableView, filling: view)
        view.addSubview(loadingIndicator, with: [
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        tableView.register(VideoTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.accessibilityIdentifier = "tableView"

        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.accessibilityIdentifier = "activityIndicator"
    }
}

extension VideoListViewController: VideoListViewProtocol {

    func showLoading(_ isLoading: Bool) {
        dispatcher.async {
            self.tableView.isUserInteractionEnabled = !isLoading
            isLoading ? self.loadingIndicator.startAnimating() : self.loadingIndicator.stopAnimating()
        }
    }

    func reloadData() {
        dispatcher.async {
            self.tableView.reloadData()
        }
    }

    func showError() {
        dispatcher.async {
            let alertController = UIAlertController(title: LocalizedString.Common.errorTitle,
                                                    message: nil,
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: LocalizedString.Common.tryAgain, style: .cancel) { [weak self] _ in
                self?.presenter.fetchVideoList()
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }

}

extension VideoListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VideoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let video = presenter.videos[indexPath.row]
        cell.render(title: video.title, description: video.description, createdAt: video.formattedCreatedDate)
        presenter.getImage(for: video.thumbnailURL) { [weak self] image, urlString in
            guard let self = self else {
                return
            }

            guard video.thumbnailURL == urlString else {
                return
            }

            self.dispatcher.async {
                cell.setImage(image: image)
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.videos.count
    }

}

extension VideoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let video = presenter.videos[indexPath.row]
        delegate?.videoListViewControllerDidSelectVideo(self, title: video.title, urlString: video.url)
    }
}
