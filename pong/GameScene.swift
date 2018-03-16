//
//  GameScene.swift
//  pong
//
//  Created by user132869 on 3/8/18.
//  Copyright © 2018 tritonjoyeux. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String: GKGraph]()
    var elements = [String: SKSpriteNode]()
    var labels = [String: SKLabelNode]()
    var scorePlayerTop = 0
    var scorePlayerBottom = 0
    var timer = 5
    
    override func didMove(to view: SKView) {
        self.elements["player_top"] = self.childNode(withName: "player_top") as! SKSpriteNode
        self.elements["player_bottom"] = self.childNode(withName: "player_bottom") as! SKSpriteNode
        self.elements["ball"] = self.childNode(withName: "ball") as! SKSpriteNode
        self.labels["score"] = self.childNode(withName: "score") as! SKLabelNode
        self.labels["timer"] = self.childNode(withName: "timer") as! SKLabelNode
        let randx = 30
        let randy = 30
        self.elements["ball"]?.physicsBody?.applyImpulse(CGVector(dx: Int(randx), dy: Int(randy)))
        let frameBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        frameBody.friction = 0
        frameBody.restitution = 1
        self.physicsBody = frameBody
    }
    
    override func update(_ currentTime: TimeInterval) {
        elements["player_top"]?.run(SKAction.moveTo(x: (elements["ball"]?.position.x)!, duration: 0))
        if(Int((elements["ball"]?.position.y)!) < -570) {
            scorePlayerTop += 1
            goal()
        }else if(Int((elements["ball"]?.position.y)!) > 570) {
            scorePlayerBottom += 1
            goal()
        }
    }
    
    func goal() {
        labels["score"]?.text = "Score     " + String(scorePlayerTop) + " : " + String(scorePlayerBottom)
        elements["ball"]?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0))
        elements["ball"]?.position = CGPoint.init(x: 0, y: 0)
        let handle1 = setTimeout(1, block: { () -> Void in
            self.labels["timer"]?.text = "3"
            let handle2 = self.setTimeout(1, block: { () -> Void in
                self.labels["timer"]?.text = "2"
                let handle3 = self.setTimeout(1, block: { () -> Void in
                    self.labels["timer"]?.text = "1"
                    let handle4 = self.setTimeout(1, block: { () -> Void in
                        self.labels["timer"]?.text = "PIRA !"
                        let handle5 = self.setTimeout(1, block: { () -> Void in
                            self.labels["timer"]?.text = ""
                        })
                        handle5.invalidate()
                    })
                    handle4.invalidate()
                })
                handle3.invalidate()
            })
            handle2.invalidate()
        })
        
        let handleF = setTimeout(5, block: { () -> Void in
            let randx = 30
            let randy = 30
            self.elements["ball"]?.physicsBody?.applyImpulse(CGVector(dx: Int(randx), dy: Int(randy)))
        })
        handleF.invalidate()
        handle1.invalidate()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch.location(in: self).y < 0 {
                elements["player_top"]?.run(SKAction.moveTo(x: touch.location(in: self).x, duration: 0))
            }
        }
    }
        
    func setTimeout(_ delay:TimeInterval, block:@escaping ()->Void) -> Timer {
        return Timer.scheduledTimer(timeInterval: delay, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: false)
    }
}
