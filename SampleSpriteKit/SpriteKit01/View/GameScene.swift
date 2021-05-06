//
//  GameScene.swift
//  SampleSpriteKit
//
//  Created by sakiyamaK on 2021/05/06.
//

import SpriteKit
import GameplayKit

final class GameScene: SKScene {

  let player = SKSpriteNode(imageNamed: "player")

  override func didMove(to view: SKView) {
    backgroundColor = SKColor.white
    player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
    addChild(player)

    run(SKAction.repeatForever(
      SKAction.sequence([
        SKAction.run(addMonster),
        SKAction.wait(forDuration: 1.0)
      ])
    ))
  }

  var randomCGFloat: CGFloat {
    CGFloat(Float(arc4random()) / 0xFFFFFFFF)
  }

  func random(min: CGFloat, max: CGFloat) -> CGFloat {
    randomCGFloat * (max - min) + min
  }

  func addMonster() {

    // Create sprite
    let monster = SKSpriteNode(imageNamed: "monster")

    // Determine where to spawn the monster along the Y axis
    let actualY = random(min: monster.size.height/2, max: size.height - monster.size.height/2)

    // Position the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    monster.position = CGPoint(x: size.width + monster.size.width/2, y: actualY)

    // Add the monster to the scene
    addChild(monster)

    // Determine speed of the monster
    let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))

    // Create the actions
    let actionMove = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: actualY),
                                   duration: TimeInterval(actualDuration))
    let actionMoveDone = SKAction.removeFromParent()
    monster.run(SKAction.sequence([actionMove, actionMoveDone]))
  }

}


/*
 let player = SKSpriteNode(imageNamed: "player")

 override func didMove(to view: SKView) {
 // 2
 backgroundColor = SKColor.white
 // 3
 player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
 // 4
 addChild(player)
 }

 */
