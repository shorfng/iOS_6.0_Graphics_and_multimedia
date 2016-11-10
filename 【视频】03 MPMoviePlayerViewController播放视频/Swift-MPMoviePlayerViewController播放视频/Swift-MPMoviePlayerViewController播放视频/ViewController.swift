//
//  ViewController.swift
//  Swift-MPMoviePlayerViewController播放视频
//
//  Created by 蓝田 on 2016/11/9.
//  Copyright © 2016年 蓝田. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    
    lazy var playerVC: MPMoviePlayerViewController = {
        
        // ① 本地媒体文件
        let infoPlistPath = Bundle.main.url(forResource: "1", withExtension: "mp4")
        let vc = MPMoviePlayerViewController(contentURL: infoPlistPath!)
        
        // ② 通过远程URL, 创建控制器 MPMoviePlayerViewController
        // let url = URL(string: "http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4")
        // let vc = MPMoviePlayerViewController(contentURL: url!)
        
        return vc!
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 表示已经弹出控制器，则直接return
        if presentedViewController != nil {
            return
        }
        
        // 2. 直接模态弹出该控制器(或者: 设置播放视图frame, 添加到需要展示的视图上)
        present(playerVC, animated: true) {
            // 3. 开始播放
            self.playerVC.moviePlayer.play()
        }
    }
}
