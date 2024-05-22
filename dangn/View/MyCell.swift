//
//  MyCell.swift
//  dangn
//
//  Created by 박다현 on 4/30/24.
//
//필터링 ???? 
import UIKit

final class MyCell: UITableViewCell {
    
    var isFav:Bool? = false
    
    //🍉셀 델리게이트 변수
    var cellDelegate:UpdateFavoriteData?
    
    var data:DataModel?{
        didSet{
            guard var data = data else { return }
            mainImageView.image = data.mainImage
            titleLabel.text = data.title
            descriptionLabel.text = data.description
            priceLabel.text = "\(String(data.price))원"
            isFav = data.isFav
            if self.isFav!{
                favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }else{
                favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }

    
private let mainImageView:UIImageView = UIImageView()
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let priceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let favoriteButton:UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var textStackView:UIStackView = {
        let sView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, priceLabel])
        sView.axis = .vertical
        sView.distribution = .equalSpacing
        sView.alignment = .leading
        return sView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setConstraints()
        favoriteButton.addTarget(self, action: #selector(heartCliked), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.mainImageView.clipsToBounds = true
        self.mainImageView.layer.cornerRadius = 10
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        [mainImageView, textStackView, favoriteButton].forEach { self.contentView.addSubview($0)}
        if self.isFav!{
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @objc func heartCliked(sender: UIButton){
        //🍉델리게이트 함수 실행
        cellDelegate?.saveFav(sender: sender, isFav:self.isFav!, index:data?.dataId ?? 0)
        if isFav!{
            isFav = false
        }else{
            isFav = true
        }
        
    }

    
    //레이아웃 제한 설정
    func setConstraints() {
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainImageView.heightAnchor.constraint(equalToConstant: 80),
            mainImageView.widthAnchor.constraint(equalToConstant: 80),
            mainImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            mainImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
        
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textStackView.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 20),
            textStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            textStackView.topAnchor.constraint(equalTo: self.mainImageView.topAnchor),
            textStackView.bottomAnchor.constraint(equalTo: self.mainImageView.bottomAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            favoriteButton.bottomAnchor.constraint(equalTo: self.textStackView.bottomAnchor),

        ])
    }

}
