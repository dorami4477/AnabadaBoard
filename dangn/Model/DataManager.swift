//
//  DataManager.swift
//  dangn
//
//  Created by 박다현 on 4/30/24.
//

import UIKit

final class DataManager{
    
    static let shared = DataManager()
    private init() {}
    
    private var dataList:[DataModel] = []
    
    func makeDataList(){
        dataList = [
            DataModel(imageArray: [UIImage(named: "image01-1.jpg"), UIImage(named: "image01-2.jpg")], title: "카메라", description: "무겁지만 아주 사진이 기가 막히게 나오는 카메라 판매 합니다.", price: 3000),
            DataModel(imageArray: [UIImage(named: "image02-1.jpg"), UIImage(named: "image02-2.jpg"), UIImage(named: "image02-3.jpg")], title: "분홍 립글로즈", description: "한번도 쓰지 않는 새 제품입니다. 인기 있는 색상이라 공홈에서는 품절상태입니다.", price: 4000),
            DataModel(imageArray: [UIImage(named: "image03-1.jpg"), UIImage(named: "image03-2.jpg")], title: "폼 클렌저", description: "블랙헤드까지 깨끗하게 지워주는 폼 클렌저입니다. 한번 사용하면 못 끊어요", price: 4400),
            DataModel(imageArray: [UIImage(named: "image04-1.jpg"), UIImage(named: "image04-2.jpg"), UIImage(named: "image04-3.jpg")], title: "립스틱", description: "색상이 아주 영롱한 립스틱입니다. 써보시면 반할 거예요.", price: 55000),
            DataModel(imageArray: [UIImage(named: "image05-1.jpg"), UIImage(named: "image05-2.jpg")], title: "아이폰 11", description: "구형 아이폰이지만 베터리 성능 아직 빵빵합니다. 외관도 아주 깨끗합니다.", price: 67000),
            DataModel(imageArray: [UIImage(named: "image06-1.jpg"), UIImage(named: "image06-2.jpg")], title: "오가닉 비누", description: "오가닉 비누로 자극적이지 않고 피부에 좋아요. 향도 좋답니다.", price: 6000),
            DataModel(imageArray: [UIImage(named: "image07-1.jpg"), UIImage(named: "image07-2.jpg")], title: "지방시 향수", description: "향수 아주 조금 썼어요. 반 이상 남았습니다. 남은 상태는 사진에서 확인하세요.", price: 86000),
            DataModel(imageArray: [UIImage(named: "image08-1.jpg"), UIImage(named: "image08-2.jpg")], title: "다용도 통들", description: "사용하지 않는 통들입니다. 다용도로 쓸 수 있어요. 여행갈 때 유용합니다. ", price: 7000),
            DataModel(imageArray: [UIImage(named: "image09-1.jpg"), UIImage(named: "image09-2.jpg")], title: "비싼 카메라", description: "고사양 카메라 입니다. 산지 얼마 안되었고요. 망가진 부분도 없습니다.", price: 2400),


        ]
    }
    
    func getDataList() -> [DataModel] {
        return dataList
    }
    
    func saveData(_ newData:DataModel){
        dataList.append(newData)
    }
    
    func updateFavData(index: Int, _ fav:Bool) {
        dataList[index].isFav = fav
        print(dataList[index].isFav!)
    }
    
    func updateData(index: Int, _ data:DataModel) {
        dataList[index] = data
        print(data)
    }
    
    func deleteData(index: Int) {
        dataList.remove(at: index)
    }
    
    func acendingData(){
        dataList = dataList.sorted { $0.price < $1.price }

    }
}
