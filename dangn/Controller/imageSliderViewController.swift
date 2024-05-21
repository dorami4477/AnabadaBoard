//
//  imageSliderViewController.swift
//  dangn
//
//  Created by 박다현 on 5/2/24.
//

import UIKit

final class imageSliderViewController: UIViewController{
    
    
    private let imageView = ImageSliderView()
    
    var data:DataModel?{
        didSet{
            //데이터가 변경되면 UIView에 데이터 넘겨줌
            imageView.data = data
        }
    }
    
    override func loadView() {
        imageView.data = data
        view = imageView
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        imageView.updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        imageView.deleteButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let images = imageView.images else { return }
        imageView.setImageSlider(images: images)
    }
    
    
    @objc func backButtonTapped(){
        dismiss(animated: true)
    }
    
    @objc func updateButtonTapped(){
        let createVC = CreateViewController()
        createVC.modalPresentationStyle = .fullScreen
        createVC.data = self.data
        self.navigationController?.pushViewController(createVC, animated: true)
    }
    
}


