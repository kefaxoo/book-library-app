//
//  BookViewController.swift
//  book-library-app
//
//  Created by Bahdan Piatrouski on 14.04.23.
//

import UIKit
import SnapKit
import SDWebImage

class BookViewController: UIViewController {

    lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "book.fill")
        imageView.tintColor = UIColor.systemPurple
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    lazy var descriptionScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private var book: BookModel
    
    init(book: BookModel) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.systemPurple
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.view.backgroundColor = UIColor.systemBackground
        setupInterface()
        OpenLibraryProvider.shared.getBookInfo(bookKey: book.key) { book in
            self.book = book
            if let description = book.description {
                self.descriptionLabel.text = "Description:\n\(description)"
                let labelSize = self.descriptionLabel.sizeThatFits(CGSize(width: self.descriptionScrollView.frame.width, height: CGFloat.greatestFiniteMagnitude))
                self.descriptionLabel.frame = CGRect(origin: CGPoint.zero, size: labelSize)
                self.descriptionScrollView.contentSize = labelSize
            } else {
                self.descriptionLabel.text = "There is no description for book"
            }
        }
        
        OpenLibraryProvider.shared.getBookRatings(bookKey: book.key) { rating in
            self.ratingLabel.text = "Rating: \(String(format: "%.02f", rating)) / 5"
        }
    }
    
    private func setupInterface() {
        if let coverKey = book.coverKey {
            coverImageView.sd_setImage(with: URL(string: "https://covers.openlibrary.org/b/olid/\(coverKey)-L.jpg"))
        }
        
        titleLabel.text = book.title
        yearLabel.text = "\(book.firstPublishYear)"
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        self.view.addSubview(coverImageView)
        self.view.addSubview(infoStackView)
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(ratingLabel)
        infoStackView.addArrangedSubview(yearLabel)
        self.view.addSubview(descriptionScrollView)
        descriptionScrollView.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        coverImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(coverImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        descriptionScrollView.snp.makeConstraints { make in
            make.top.equalTo(coverImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.width.equalTo(descriptionScrollView.snp.width)
        }
    }
}
