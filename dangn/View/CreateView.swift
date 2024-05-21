//
//  CreateView.swift
//  dangn
//
//  Created by 박다현 on 5/10/24.
//

import UIKit

final class CreateView: UIView {
    
    
    // 이미지 선택 UI
    lazy var imagesView:UIStackView = {
        let view = UIStackView(arrangedSubviews: [selectImageLabel, imageCountLabel])
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 3
        return view
    }()
    
    private let selectImageLabel:UIImageView = {
        let iamgeView = UIImageView(image: UIImage(systemName: "camera.fill"))
        iamgeView.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        iamgeView.translatesAutoresizingMaskIntoConstraints = false
        return iamgeView
    }()
    
    let imageCountLabel:UILabel = {
        let label = UILabel()
        label.text = "0/5"
        label.font = UIFont.systemFont(ofSize:13)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 선택된 이미지들 보이는 뷰
    private let mainImageView0:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "square.dashed")
        return imageView
    }()
    
    private let mainImageView1:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "square.dashed")
        return imageView
    }()
    private let mainImageView2:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "square.dashed")
        return imageView
    }()
    private let mainImageView3:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "square.dashed")
        return imageView
    }()
    private let mainImageView4:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "square.dashed")
        return imageView
    }()
    
    lazy var imageArray:[UIImageView] = [mainImageView0, mainImageView1, mainImageView2, mainImageView3, mainImageView4]
    // 이미지 뷰 묶음
    private lazy var imgStackView:UIStackView = {
        let sView = UIStackView(arrangedSubviews: [mainImageView0, mainImageView1, mainImageView2, mainImageView3, mainImageView4])
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.axis = .horizontal
        sView.distribution = .fillEqually
        sView.alignment = .leading
        sView.spacing = 5
        return sView
    }()
    
    // 타이틀 텍스트 필드
    let titleTextField:UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "제목을 입력하세요."
        tf.frame.size.height = 48
        tf.layer.borderWidth = 1
        tf.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let descriptionTextField:UITextView = {
        let tf = UITextView()
        tf.text = "설명을 입력하세요."
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.frame.size.height = 200
        tf.layer.borderWidth = 1
        tf.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        tf.textColor = .lightGray
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let priceTextField:UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.frame.size.height = 48
        tf.placeholder = "￦ 가격을 입력하세요."
        tf.layer.borderWidth = 1
        tf.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var textStackView:UIStackView = {
        let sView = UIStackView(arrangedSubviews: [titleTextField, descriptionTextField, priceTextField])
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.axis = .vertical
        sView.distribution = .equalSpacing
        sView.alignment = .fill
        sView.spacing = 10
        return sView
    }()
    
    
    let updateButton:UIButton = {
        let button = UIButton()
        button.frame.size.height = 48
        button.setTitle("게시하기", for: .normal)
        button.backgroundColor = .systemMint
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        imagesView.addSubview(selectImageLabel)
        [imagesView, imgStackView,textStackView, updateButton].forEach{ self.addSubview($0)}
        setConstraints()
        setImages()
        descriptionTextField.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [updateButton, imagesView, titleTextField, descriptionTextField, priceTextField].forEach{
            $0.layer.cornerRadius = 5
            $0.clipsToBounds = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImages(){
        imageArray.forEach { image in
            image.widthAnchor.constraint(equalToConstant: 50).isActive = true
            image.heightAnchor.constraint(equalToConstant: 50).isActive = true
            image.contentMode = .scaleToFill
            image.tintColor = .lightGray
        }
    }
    
    //레이아웃 제한 설정
    func setConstraints(){
        
        NSLayoutConstraint.activate([
            imagesView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            imagesView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            imagesView.widthAnchor.constraint(equalToConstant: 50),
            imagesView.heightAnchor.constraint(equalToConstant: 50),
            
            selectImageLabel.topAnchor.constraint(equalTo: imagesView.topAnchor, constant: 3),
            imageCountLabel.topAnchor.constraint(equalTo: selectImageLabel.bottomAnchor, constant: 2),
            
            imgStackView.topAnchor.constraint(equalTo: imagesView.topAnchor),
            imgStackView.leadingAnchor.constraint(equalTo: imagesView.trailingAnchor, constant: 10),
            
            textStackView.topAnchor.constraint(equalTo: imagesView.bottomAnchor, constant: 20),
            textStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            textStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 180),
            priceTextField.heightAnchor.constraint(equalToConstant: 40),
            
            updateButton.heightAnchor.constraint(equalToConstant: 40),
            updateButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            updateButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            updateButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
        ])
        
    }
    

}


extension CreateView: UITextViewDelegate {
   
   func textViewDidBeginEditing(_ textView: UITextView) {

       if textView.textColor == UIColor.lightGray {
           textView.text = nil
           textView.textColor = UIColor.black
       }
       
   }
   // UITextView의 placeholder
   func textViewDidEndEditing(_ textView: UITextView) {
       if textView.text.isEmpty {
           textView.text = "설명를 입력하세요"
           textView.textColor = UIColor.lightGray
       }
   }
   
}
