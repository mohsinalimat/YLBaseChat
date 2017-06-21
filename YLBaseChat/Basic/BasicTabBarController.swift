//
//  BasicTabBarController.swift
//  YLBaseChat
//
//  Created by clj on 17/6/21.
//  Copyright © 2017年 yl. All rights reserved.
//

import UIKit

class BasicTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createSubviewController();
    }

    func createSubviewController() {
        let chatVC = ChatViewController();
        let chatItem:UITabBarItem = UITabBarItem(title:"微信" , image:UIImage(named:"home"), selectedImage:UIImage(named:"home_hight"));
        chatVC.tabBarItem = chatItem;
        let homeNav = UINavigationController(rootViewController: chatVC);
        
        let friendVC = FriendsViewController();
        let friendItem:UITabBarItem = UITabBarItem(title: "通讯录", image: UIImage(named:"order"), selectedImage: UIImage(named: "order_hight"));
        friendVC.tabBarItem = friendItem;
        let friendNav = UINavigationController(rootViewController: friendVC);
        
        let findVC = FindViewController();
        let findItem:UITabBarItem = UITabBarItem(title: "发现", image: UIImage(named:"find"), selectedImage: UIImage(named: "find_hight"));
        findVC.tabBarItem = findItem;
        let findNav = UINavigationController(rootViewController: findVC);
        
        let meVC = MeViewController();
        let meItem:UITabBarItem = UITabBarItem(title: "我", image: UIImage(named:"me"), selectedImage: UIImage(named:"me_hight"));
        meVC.tabBarItem = meItem;
        let meNav = UINavigationController(rootViewController: meVC);
        
        let tabArray = [homeNav,friendNav,findNav,meNav];
        self.viewControllers = tabArray;
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
