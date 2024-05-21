

import UIKit


final class ImageSliderView: UIView{
    
    var images:[UIImage?]?
    
    var data:DataModel?{
        didSet{
            guard let data = data else { return }
            images = data.imageArray
            titleLabel.text = data.title
            descriptionLabel.text = data.description
            priceLabel.text = "\(String(data.price))원"
        }
    }
    
    lazy var imageScrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
      }()

    lazy var imagePageControl:UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        guard let images = self.images else { return pageControl}
        pageControl.numberOfPages = images.count
        pageControl.pageIndicatorTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.hidesForSinglePage = true
        return pageControl
      }()

    private var imageNumberLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.5)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.text = "0/1"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        return label
      }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let priceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let lineView:UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        // view.frame.size.height = 0.2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var textStackView:UIStackView = {
        let sView = UIStackView(arrangedSubviews: [titleLabel, lineView, descriptionLabel, priceLabel])
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.axis = .vertical
        sView.distribution = .equalSpacing
        sView.alignment = .leading
        return sView
    }()
    
    
    let updateButton:UIButton = {
        let button = UIButton()
        button.setTitle("수정하기", for: .normal)
        button.backgroundColor = .systemMint
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    let deleteButton:UIButton = {
        let button = UIButton()
        button.setTitle("삭제하기", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    private lazy var btnStackView:UIStackView = {
        let sView = UIStackView(arrangedSubviews: [updateButton, deleteButton])
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.axis = .horizontal
        sView.distribution = .fillEqually
        sView.spacing = 10
        sView.alignment = .center
        return sView
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
      //  imageScrollView.delegate = self
        [imageScrollView,textStackView, btnStackView].forEach{ addSubview($0)}
        

    }

    override func layoutSubviews() {
        guard let images = self.images else { return }
        setImageSlider(images: images)
        
        setUpUIConstraint()
        
        updateButton.layer.cornerRadius = 10
        updateButton.clipsToBounds = true
        deleteButton.layer.cornerRadius = 10
        deleteButton.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUIConstraint() {
        imageScrollView.contentInsetAdjustmentBehavior = .never
        NSLayoutConstraint.activate([
            
            imageScrollView.topAnchor.constraint(equalTo: self.topAnchor),
            imageScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
           // imageScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            imageScrollView.heightAnchor.constraint(equalToConstant: imageScrollView.contentSize.width / Double(images?.count ?? 1)),
            
            imagePageControl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imagePageControl.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imagePageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25),
            
            
            imageNumberLabel.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 20),
            imageNumberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),

        ])
        
        
        NSLayoutConstraint.activate([
            
            textStackView.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 20),
            textStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            lineView.widthAnchor.constraint(equalTo: textStackView.widthAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            
            btnStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            btnStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            btnStackView.widthAnchor.constraint(equalToConstant: 210),
            deleteButton.leadingAnchor.constraint(equalTo: updateButton.trailingAnchor, constant: 10),
        ])
    }
    
    func setImageSlider(images: [UIImage?]) { // scrolliVew에 imageView 추가하는 함수
        
        for index in 0..<images.count {
          let imageView = UIImageView()
          imageView.image = images[index]
          imageView.contentMode = .scaleAspectFill
          imageView.layer.cornerRadius = 5
          imageView.clipsToBounds = true

          let xPosition = self.frame.width * CGFloat(index)

          imageView.frame = CGRect(x: xPosition,
                                   y: 0,
                                   width: self.frame.width,
                                   height: self.frame.width)

            imageScrollView.contentSize.width = self.frame.width * CGFloat(index+1)
            imageScrollView.addSubview(imageView)
            imageScrollView.addSubview(imagePageControl)
            imageScrollView.addSubview(imageNumberLabel)
            
        }
      }
    
}

