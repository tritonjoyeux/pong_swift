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
    
    override func didMove(to view: SKView) {
        self.elements["player_top"] = self.childNode(withName: "player_top") as! SKSpriteNode
        self.elements["ball"] = self.childNode(withName: "ball") as! SKSpriteNode
        self.elements["ball"]?.physicsBody?.applyImpulse(CGVector( dx: 30, dy: 30))
        let frameBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        frameBody.friction = 0
        frameBody.restitution = 1
        self.physicsBody = frameBody
    }
    
    override func update(_ currentTime: TimeInterval) {
        elements["player_top"]?.run(SKAction.moveTo(x: (elements["ball"]?.position.x)!, duration: 0.5))
    }
}
