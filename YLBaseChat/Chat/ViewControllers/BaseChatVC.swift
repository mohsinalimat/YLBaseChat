//
//  BaseChatVC.swift
//  YLBaseChat
//
//  Created by yl on 17/5/12.
//  Copyright © 2017年 yl. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class BaseChatVC: UIViewController {
    
    // 表单
    var tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
    
    var dataArray = Array<Message>()
    
    var userInfo:UserInfo!
    
    deinit {
        print("====\(self)=====>被释放")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.red
        
        title = "聊天室"
        
        layoutUI()
        
        loadData()
    }
    
    
    func layoutUI() {
        
        let chatView =  ChatView.init(frame: CGRect.zero)
        chatView.delegate = self
        view.addSubview(chatView)
        
        chatView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.lightGray
        tableView.tableFooterView = UIView()
        chatView.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.left.right.equalTo(0)
            make.bottom.equalTo(chatView.evInputView.snp.top)
        }
        
    }
    
    func loadData() {
        
        dataArray += userInfo.messages
        
        tableView.reloadData()
        
        efScrollToLastCell()
    }
    
    // 滚到最后一行
    fileprivate func efScrollToLastCell() {
        tableView.scrollToRow(at: IndexPath.init(row: dataArray.count-1, section: 0), at: UITableViewScrollPosition.middle, animated: true)
    }
    
}


// MARK: - UITableViewDelegate,UITableViewDataSource
extension BaseChatVC:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let message = dataArray[indexPath.row]
        
        let messageBody = message.messageBody
        
        if(message.direction == MessageDirection.send.rawValue){
            cell.textLabel?.text = "我:  " + (messageBody?.text)!
        }else{
            cell.textLabel?.text = "对方: " + (messageBody?.text)!
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}


// MARK: - ChatViewDelegate
extension BaseChatVC:ChatViewDelegate {
    
    func epSendMessageText(_ text: String) {
        
        let message = Message()
        message.timestamp = String(Int(Date().timeIntervalSince1970))
        message.direction = MessageDirection.receive.rawValue
        
        let messageBody = MessageBody()
        messageBody.type = MessageBodyType.text.rawValue
        messageBody.text = text
        
        message.messageBody = messageBody
        
        RealmManagers.shared.commitWrite {
            userInfo.messages.append(message)
        }
        
        dataArray.append(userInfo.messages.last!)
        tableView.reloadData()
        
        efScrollToLastCell()
    }
    
    func epTextViewAutoHeightComplated() {
        efScrollToLastCell()
    }
}