//
//  imageSliderViewController.swift
//  dangn
//
//  Created by 박다현 on 5/2/24.
//

import UIKit

final class imageSliderViewController: UIViewController{
    
    
    private let imageView = ImageSliderView()
    
    //싱글톤 데이터매니저
    let dataManager = DataManager.shared
    
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
        imageView.deleteButton.addTarget(self, action: #selector(deleteButtonTaaped), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let images = imageView.images else { return }
        imageView.setImageSlider(images: images)
    }
    
    
    @objc func deleteButtonTaaped(){
        let alert = UIAlertController(title: "삭제하기", message: "정말로 삭제하시겠습니까?", preferredStyle: .alert)
        
        let delete = UIAlertAction(title: "삭제", style: .destructive){_ in 
            self.dataManager.deleteData(index: self.data?.dataId ?? 0)
            
            let index = self.navigationController!.viewControllers.count - 2
            let vc = self.navigationController?.viewControllers[index] as! ViewController

            vc.filtered.removeAll(where: { $0.dataId == self.data?.dataId})
            
            self.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancel)
        alert.addAction(delete)
        
        present(alert, animated: true)
        
    }
    
    @objc func updateButtonTapped(){
        let createVC = CreateViewController()
        createVC.modalPresentationStyle = .fullScreen
        createVC.data = self.data
        self.navigationController?.pushViewController(createVC, animated: true)
    }
    
}


