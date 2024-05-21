//
//  CreateViewController.swift
//  dangn
//
//  Created by 박다현 on 5/2/24.
//

import UIKit
import PhotosUI

final class CreateViewController: UIViewController {

    private let createView = CreateView()
    
    //싱글톤 데이터매니저
    let dataManager = DataManager.shared
    
    var data:DataModel?{
        didSet{
            guard let data = data else { return }
            title = "게시물 수정"
            photoImages = data.imageArray
            createView.titleTextField.text = data.title
            createView.descriptionTextField.text = data.description
            createView.priceTextField.text = String(data.price)
            if data.description != nil {
                createView.descriptionTextField.textColor = .black
            }
        }
    }
    // 이미지 선택시 담을 배열
    var photoImages: [UIImage?]? = []
    
    override func loadView() {
        view = createView
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "새로운 개시물"
        setupTapGestures()
        setImages()
        createView.updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
    }
    
    
    func setImages(){
        var i = 0
        guard let photoImages else { return }
        photoImages.forEach { image in
            guard let image else { return }
            createView.imageArray[i].image = image
            i += 1
        }
    }
 
    @objc func updateButtonTapped(){
        
        if data == nil{
            //버튼 클릭시 새로운 데이터인 경우
            let title = createView.titleTextField.text
            let description = createView.descriptionTextField.text
            guard let price = Int(createView.priceTextField.text!) else { return }
            
            let newData = DataModel(imageArray: photoImages, title: title, description: description, price: price)
            dataManager.saveData(newData)
            
        }else{
            //기존 데이터를 업데이트 하는 겨우
            
            let title = createView.titleTextField.text
            let description = createView.descriptionTextField.text
            guard let price = Int(createView.priceTextField.text!) else { return }
            
            data!.imageArray = photoImages
            data!.title = title
            data!.description = description
            data!.price = price

            dataManager.updateData(index: data!.dataId, data!)
            
            let index = navigationController!.viewControllers.count - 2
            // 전 화면에 접근하기 위함
            let vc = navigationController?.viewControllers[index] as! imageSliderViewController
            // 전 화면의 모델에 접근해서 멤버를 업데이트
            vc.data = data
            
        }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - 이미지뷰가 눌렸을때의 동작 설정
    // 제스쳐 설정 (이미지뷰가 눌리면, 실행)
    func setupTapGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpImageView))
        createView.imagesView.addGestureRecognizer(tapGesture)
        createView.imagesView.isUserInteractionEnabled = true
        createView.imagesView.contentMode = .scaleAspectFit
    }
    
    @objc func touchUpImageView() {
        print("이미지뷰 터치")
        setupImagePicker()
    }
    
    func setupImagePicker() {
        // 기본설정 셋팅
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 5
        configuration.filter = .any(of: [.images, .videos])
        
        // 기본설정을 가지고, 피커뷰컨트롤러 생성
        let picker = PHPickerViewController(configuration: configuration)
        // 피커뷰 컨트롤러의 대리자 설정
        picker.delegate = self
        // 피커뷰 띄우기
        self.present(picker, animated: true, completion: nil)
    }
    
    deinit {
        print("디테일 뷰컨트롤러 해제")
    }
}

// MARK: - PHPickerViewControllerDelegate
extension CreateViewController: PHPickerViewControllerDelegate {
    
    // 사진이 선택이 된 후에 호출되는 메서드
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        // 피커뷰 dismiss
        picker.dismiss(animated: true)

        if !(results.isEmpty)  {
            self.photoImages?.removeAll()
            self.createView.imageArray.forEach { image in
                image.image = UIImage(systemName: "square.dashed")
            }
            
            for i in 0..<results.count{
                let itemProvider = results[i].itemProvider
                if itemProvider.canLoadObject(ofClass: UIImage.self){
                    itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        self.photoImages?.append(image as? UIImage)

                        DispatchQueue.main.sync {
                            self.createView.imageArray[i].image = image as? UIImage
                            self.createView.imageCountLabel.text = "\(results.count)/5"
                        }
                    }
                }
            }
            
        }
    }
}




