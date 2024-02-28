//
//  ViewController.swift
//  MVVM cmdB
//
//  Created by Сергей Сырбу on 01.02.2024.
//

import UIKit

final class MainViewController: UIViewController {

    private let mainUIView = MainUIView()
    private var viewModel: IMainViewModel!
    var cellDataSource = [MainCellViewModel]()
    
    init(viewModel: IMainViewModel!) {
        super .init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = mainUIView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindingViewModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.getUsers()
    }
    private func setupTableView() {
        title = "Main Screen"
        mainUIView.tableView.dataSource = self
        mainUIView.tableView.delegate = self
    }
    private func bindingViewModel() {
        viewModel.isLoading.bind {[weak self] isLoading in
            guard let self, let isLoading else {return}
            DispatchQueue.main.async {
                isLoading ? self.mainUIView.activityIndicator.startAnimating() : self.mainUIView.activityIndicator.stopAnimating()
            }
            viewModel.cellDataSource.bind { [weak self] users in
                guard let self, let users else { return }
                cellDataSource = users
                DispatchQueue.main.async {
                    self.mainUIView.tableView.reloadData()
                }
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier, for: indexPath) as? MainCell else {fatalError()}
        cell.setupCell(viewModel: cellDataSource[indexPath.row] )
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
