//
//  MainViewController.swift
//  book-library-app
//
//  Created by Bahdan Piatrouski on 14.04.23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    lazy var booksTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BookTableViewCell.self)
        return tableView
    }()
    
    private var books = [BookModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        OpenLibraryProvider.shared.getTrendingBooks { books in
            self.books = books
            self.booksTableView.reloadData()
        }

    }
    
    private func setupInterface() {
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        self.view.addSubview(booksTableView)
    }
    
    private func setupConstraints() {
        booksTableView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.id, for: indexPath)
        guard let bookCell = cell as? BookTableViewCell else { return cell }
        
        bookCell.set(book: books[indexPath.row])
        return bookCell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(BookViewController(book: books[indexPath.row]), animated: true)
    }
}
