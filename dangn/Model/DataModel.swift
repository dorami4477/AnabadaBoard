//
//  dataModel.swift
//  dangn
//
//  Created by 박다현 on 4/30/24.
//

import UIKit

//🍉즐겨찾기 델리게이트 프로토콜
protocol UpdateFavoriteData:AnyObject{
    func saveFav(sender:UIButton, isFav:Bool, index:Int)
}

struct DataModel{
    
    lazy var mainImage:UIImage? = {
        guard let imageArray else {
            return UIImage(systemName: "carrot")!
        }
        let firstImg = imageArray.first
        return firstImg ?? UIImage(systemName: "carrot")
    }()
    
    var imageArray:[UIImage?]?
    
    static var dataIndex: Int = 0
    
    let dataId:Int
    var title:String?
    var description:String?
    var price:Int
    var isFav:Bool?
    
    init(imageArray:[UIImage?]?, title:String?, description:String?, price:Int){
        self.dataId = DataModel.dataIndex
        self.imageArray = imageArray
        self.title = title
        self.description = description
        self.price = price
        self.isFav = false
        
        DataModel.dataIndex += 1
    }
}
