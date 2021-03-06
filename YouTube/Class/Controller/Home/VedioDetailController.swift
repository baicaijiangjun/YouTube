//
//  VedioDetailController.swift
//  YouTube
//
//  Created by Turbo on 2020/5/26.
//  Copyright © 2020 turbo. All rights reserved.
//

import UIKit

typealias playEnd = (_ palyTime: Int)->()

class VedioDetailController: BaseViewController {
    
    let menuTitles = ["What Does Jared Kushner Believe?", "hqdefault-2", "Whoner & losers", "hqdefault-1", "Cnn:the age channage", "hqdefault-6", "What Does Jared Kushner Believe?", "hqdefault-2", "Whoner & losers", "hqdefault-1", "Cnn:the age channage", "hqdefault-6"]
    let logoImages = ["channel1", "channel2", "channel3", "channel4", "channel5", "channel6", "channel1", "channel2", "channel3", "channel4", "channel5", "channel6"]
    let descs = ["Molly   2020-05-26 18:42", "Seeker   2020-05-26 17:01", "Molly   2020-05-26 18:42", "Molly   2020-05-26 18:42", "Molly   2020-05-26 18:42", " 2020-05-26 18:42", "Molly   2020-05-26 18:42", "Seeker   2020-05-26 17:01", "Molly   2020-05-26 18:42", "Molly   2020-05-26 18:42", "Molly   2020-05-26 18:42", " 2020-05-26 18:42"]
    let times = ["01:52", "03:08", "00:53", "02:15", "03:21", "04:28", "01:52", "03:08", "00:53", "02:15", "03:21", "04:28"]
    
    var tableview : UITableView?
    var vedioId: String!
    var vedioData: VedioData!
    var status: Bool! = false
    var end: playEnd!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Vedio"
        self.setLeftImageNamed(name: "back", action: #selector(popBackController))
        self.setRightImageNamed(name: "more", action: #selector(pushCommentList))
        setupUI()
    }
    
    override func popBackController() {
        if (end != nil) {
            end!(100)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pushCommentList() {
        let trendingLine = TrendingLineViewController()
        trendingLine.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(trendingLine, animated: true)
    }
    
    private func setupUI(){
        setupTableView()
    }
    
    private lazy var leftBarView: UIView = {
        return UIView(frame: CGRect(x: 0, y: 0, width: 88, height: 44))
    }()
    
    private func setupTableView(){
        tableview = UITableView(frame: CGRect(x: 0, y: 0, width: MainScreenWidth, height: MainScreenHeight - NavBarHeight), style: UITableView.Style.grouped)
        tableview?.delegate = self
        tableview?.dataSource = self
        tableview?.register(RecomandVedioCell.self, forCellReuseIdentifier: "RecomandVedioCell")
        tableview?.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableview?.sectionHeaderHeight = 0
        tableview?.sectionFooterHeight = 0
        view.addSubview(tableview!)
        tableview?.tableHeaderView = createHeaderView()
        let footerView = UIView.init(frame: CGRect(x: 0, y: 0, width: MainScreenWidth, height: 0.1))
        tableview?.tableFooterView = footerView
    }
    
    private func createHeaderView() ->VedioDetailHeaderView {
        let headerView = VedioDetailHeaderView(frame: CGRect(x: 0, y: 0, width: MainScreenWidth, height: 385))
        headerView.fillViewData(data: vedioData)
        return headerView
    }
    
    @objc func switchStatus(sender:UIButton ) {
        let alert = UIAlertController(title: "Warning", message: "Status will Open", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            self.showDetailHint(hint: "Switch cancel")
        }))
        alert.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: { action in
            sender.isSelected = !sender.isSelected
            self.showDetailHint(hint: "Status opened")
            self.status = sender.isSelected
        }))
        present(alert, animated: true)
    }
    
}

extension VedioDetailController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecomandVedioCell", for:indexPath) as! RecomandVedioCell
        cell.vedioImageView.image = UIImage(named: menuTitles[indexPath.row])
        cell.titleLabel.text = menuTitles[indexPath.row]
        cell.descriptionLabel.text = descs[indexPath.row]
        cell.timeLabel.text = times[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView(frame: CGRect(x: 0, y: 0, width: MainScreenWidth, height: 40))
        sectionHeader.backgroundColor = UIColor.white
        
        let textL = UILabel(frame: CGRect(x: 15, y: 10, width: 100, height: 20))
        textL.text = "Up Next"
        textL.font = UIFont.boldSystemFont(ofSize: 14)
        textL.textColor = kAppTextColor
        sectionHeader .addSubview(textL)
        
        let switchBtn = UIButton(frame: CGRect(x: MainScreenWidth-70, y: 5, width: 60, height: 30))
        switchBtn.setImage(UIImage(named: "unconfirm"), for: UIControl.State.normal)
        switchBtn.setImage(UIImage(named: "confirm"), for: UIControl.State.selected)
        switchBtn.isSelected = self.status
        switchBtn.addTarget(self, action: #selector(switchStatus(sender:)), for: .touchUpInside)
        sectionHeader.addSubview(switchBtn)
        
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTitles.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trendingLine = TrendingLineViewController()
        trendingLine.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(trendingLine, animated: true)
    }
}
