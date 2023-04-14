//
//  BookTableViewCell.swift
//  book-library-app
//
//  Created by Bahdan Piatrouski on 14.04.23.
//

import UIKit
import SnapKit
import SDWebImage

class BookTableViewCell: UITableViewCell {

    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .top
        return stackView
    }()
    
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
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private var book: BookModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(book: BookModel) {
        self.book = book
        titleLabel.text = book.title
        yearLabel.text = "\(book.firstPublishYear)"
        if let coverKey = book.coverKey {
            coverImageView.sd_setImage(with: URL(string: "https://covers.openlibrary.org/b/olid/\(coverKey)-M.jpg"))
        }
        
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        self.contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(coverImageView)
        mainStackView.addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(yearLabel)
    }
    
    private func setupConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().offset(-10)
        }
        
        coverImageView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
    }

}
