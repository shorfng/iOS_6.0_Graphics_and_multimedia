//
//  ViewController.swift
//  Swift-AVPlayerViewController播放视频
//
//  Created by 蓝田 on 2016/11/9.
//  Copyright © 2016年 蓝田. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    lazy var playerVC: AVPlayerViewController = {
        
        // ① 本地媒体文件
        let infoPlistPath = Bundle.main.url(forResource: "1.mp4", withExtension:nil)
        let player = AVPlayer(url: infoPlistPath!)
        
        // ② 通过远程URL创建AVPlayer
        // let url = URL(string: "http://v1.mukewang.com/3e35cbb0-c8e5-4827-9614-b5a355259010/L.mp4")
        // let player = AVPlayer(url: url!)
        
        // 2.根据AVPlayer, 创建AVPlayerViewController控制器
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        
        // 设置画中画(ipad)
        // playerVC.allowsPictureInPicturePlayback = true
        
        return playerVC
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if presentedViewController != nil {
            return
        }
        
        // 3.直接弹出此控制器
        present(playerVC, animated: true) {
            // 4.开始播放
            self.playerVC.player?.play()
        }
    }
}
