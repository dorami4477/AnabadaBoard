//
//  ViewController.swift
//  dangn
//
//  Created by 박다현 on 4/30/24.
//

import UIKit

final class ViewController: UIViewController, UpdateFavoriteData {

    
    
    private let tableView:UITableView = UITableView()
    
    let dataManager = DataManager.shared
    
    //즐겨찾기 필터 온오프 확인용 변수
    var onHeartfilter:Bool = false
    
    //즐겨찾기한 데이터를 저장할 변수
    var filtered:[DataModel] = []

    //🌰 왼쪽 바버튼 선언
    var leftBarButtonItem = UIBarButtonItem()
    
    var sortedBy: Int = 1
    
    //정렬을 바꾼 데이터를 저장할 변수
    var newArrangedData:[DataModel] = []
    
    
    //게시물 추가 버튼
    let btn:UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setConstraints()
        dataManager.makeDataList()
        setupNavi()
        btn.addTarget(self, action: #selector(nextVC), for: .touchUpInside)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btn.layer.cornerRadius = btn.frame.width / 2
        btn.clipsToBounds = true
    }
    
    
    //테이블 뷰 설정
    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        view.addSubview(btn)
        tableView.register(MyCell.self, forCellReuseIdentifier: "MyCell")
        tableView.rowHeight = 100
    }
    
    //🌰  네비게이션 컨트롤러 설정
    func setupNavi(){
        view.backgroundColor = .white
        title = "Anabada"

        leftBarButtonItem = UIBarButtonItem(title: "Sort",menu: createMenu())
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let heart = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(heartfilterTapped))
        navigationItem.rightBarButtonItem = heart
    }
    
    //레이아웃 제한 설정
    func setConstraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            btn.widthAnchor.constraint(equalToConstant: 50),
            btn.heightAnchor.constraint(equalToConstant: 50),
            btn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            btn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    

    
    //🌰 pull down 버튼 생성
    private func createMenu(actionTitle: String? = nil) -> UIMenu {
        let menu = UIMenu(title: "Sorted by", children: [
            UIAction(title: "최신 순") { [unowned self] action in
                self.leftBarButtonItem.menu = createMenu(actionTitle: action.title)
                sortedBy = 1
                arragingData(title: action.title)
                tableView.reloadData()
            },
            UIAction(title: "최저가 순") { [unowned self] action in
                self.leftBarButtonItem.menu = createMenu(actionTitle: action.title)
                sortedBy = 2
                arragingData(title: action.title)
                tableView.reloadData()
            },
            UIAction(title: "최고가 순") { [unowned self] action in
                self.leftBarButtonItem.menu = createMenu(actionTitle: action.title)
                sortedBy = 3
                arragingData(title: action.title)
                tableView.reloadData()
            }
        ])
        
        if let actionTitle = actionTitle {
            menu.children.forEach { action in
                guard let action = action as? UIAction else {
                    return
                }
                if action.title == actionTitle {
                    action.state = .on
                }
            }
        } else {
            let action = menu.children.first as? UIAction
            action?.state = .on
        }
        
        return menu
    }

    //sort 클릭한 버튼별로 데이터 정렬 바꾸어 담기
    func arragingData(title: String){
        if title == "최신 순"{
            newArrangedData = dataManager.getDataList()
        }else if title == "최저가 순"{
            newArrangedData = dataManager.getDataList().sorted{ $0.price < $1.price }
            print(newArrangedData)
        }else if title == "최고가 순"{
            newArrangedData = dataManager.getDataList().sorted{ $0.price > $1.price }
            print(newArrangedData)
        }
    }
    
    //하트 필터 클릭시
    @objc func heartfilterTapped(){
        print("하트필터탭드")
        if onHeartfilter{
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            onHeartfilter = false
            self.tableView.reloadData()
        }else{
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            onHeartfilter = true
            tableView.reloadData()
        }
    }
    
    //하단 플러스 버튼 클릭시 create페이지로 이동
    @objc func nextVC(){
        let createVC = CreateViewController()
        self.navigationController?.pushViewController(createVC, animated: true)
    }
    
    //🍉fav 델리게이트 함수
    func saveFav(sender:UIButton, isFav:Bool, index:Int) {
        if isFav{
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            dataManager.updateFavData(index: index, false)
            filtered.removeAll { $0.dataId == index }
            print(filtered.count)
        }else{
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            dataManager.updateFavData(index: index, true)
            if !filtered.contains(where: { $0.dataId == index }){
                filtered.append(dataManager.getDataList()[index])
            }
            
            print(filtered.count)
        }
    }

}


// MARK: - UITableViewDataSource
extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.getDataList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
       
        if dataManager.getDataList()[indexPath.row].isFav! {
            if !filtered.contains(where: { $0.dataId == dataManager.getDataList()[indexPath.row].dataId }){
                filtered.append(dataManager.getDataList()[indexPath.row])
            }
        }
 
        //즐겨찾기 필터가 온상태이면
        if onHeartfilter{
           if(indexPath.row > filtered.count-1){
                return cell
            } else {
                cell.data = filtered[indexPath.row]
            }
            
        }else{
            //필터가 오프 상태이면서
            //sort 버튼 클릭 상태에 따라 다른 데이터 전송
            if sortedBy == 1{
                cell.data = dataManager.getDataList()[indexPath.row]
            }else if sortedBy == 2{
                cell.data = newArrangedData[indexPath.row]
            }else if sortedBy == 3{
                cell.data = newArrangedData[indexPath.row]

            }
        }
        //🍉셀 델리게이트
        cell.cellDelegate = self
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let detailVC = imageSliderViewController()
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.data = dataManager.getDataList()[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
        //  }
    }
}


