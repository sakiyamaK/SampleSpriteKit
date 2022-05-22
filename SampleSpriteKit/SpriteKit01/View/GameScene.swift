//
//  GameScene.swift
//  SampleSpriteKit
//
//  Created by sakiyamaK on 2021/05/06.
//

import SpriteKit
import GameplayKit

extension CGPoint {
    func distance(from point: CGPoint) -> CGFloat {
        return hypot(point.x - x, point.y - y)
    }
}

final class GameView: SKView {
    
    private var gameScene: GameScene = .init(size: .zero)
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        gameScene.size = bounds.size
        gameScene.scaleMode = .resizeFill
        self.presentScene(gameScene)
    }
}

final class GameScene: SKScene {
    
    let player = SKSpriteNode(imageNamed: "player")

    override func didMove(to view: SKView) {
        NotificationCenter.default.addInjectionObserver(self, selector: #selector(setupLayout), object: nil)
        NotificationCenter.default.addInjectionObserver(self, selector: #selector(moveNodes(location:previous:)), object: nil)
        NotificationCenter.default.addInjectionObserver(self, selector: #selector(configure), object: nil)
    }
    
    override var size: CGSize {
        didSet {
            configure()
            setupLayout()
        }
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = SKColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let previous = touch.previousLocation(in: self)
        guard location.distance(from: previous) > 0.00001 else { return }
        moveNodes(location: location, previous: previous)

        super.touchesMoved(touches, with: event)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
        

}


@objc private extension GameScene {
    func moveNodes(location: CGPoint, previous: CGPoint) {
        guard location.distance(from: previous) > 0.00001 else { return }

        let x = location.x - previous.x
        let y = location.y - previous.y
        
        for (idx, node) in children.enumerated() {
            let distance = node.position.distance(from: location)
            let acceleration: CGFloat = pow(distance, 1/2)
            let direction = CGVector(dx: x * acceleration, dy: y * acceleration)
            node.physicsBody?.applyForce(direction)
        }
    }
    
    func configure() {
        physicsWorld.gravity = .zero
        
        physicsBody = {
            let body = SKPhysicsBody(edgeLoopFrom: self.frame)
            body.collisionBitMask = 0b0001
            body.categoryBitMask = 0b0001
            return body
        }()
    }
    
    func setupLayout() {
        
        guard size != .zero else { return }
        
        removeAllChildren()
        
        let strength = Float(max(size.width, size.height))
        let radius = strength.squareRoot() * 100

        let magneticField: SKFieldNode = {
            let node = SKFieldNode.radialGravityField()
            node.region = SKRegion(radius: radius)
            node.minimumRadius = radius
            node.strength = strength
            node.position = CGPoint(x: size.width / 2, y: size.height / 2)
            return node
        }()

        addChild(magneticField)
                
        (0...100).compactMap { (idx) -> SKShapeNode in
            let shape = SKShapeNode(circleOfRadius: size.width/100)
            shape.fillColor = .systemRed
            
            let body = SKPhysicsBody(polygonFrom: shape.path!)
            body.collisionBitMask = 0b0001
            body.categoryBitMask = 0b0001
            body.allowsRotation = false
            body.friction = 0
            body.linearDamping = 1
            shape.physicsBody = body

            
            shape.position = .init(x: CGFloat.random(in: (0...size.width)), y: CGFloat.random(in: (0...size.height)))
            return shape
        }.forEach {
            addChild($0)
        }
    }
}

//    func addMonster(node: SKNode) {
//
//        // Create sprite
//        let monster = SKSpriteNode(imageNamed: "monster")
//
//        // Determine where to spawn the monster along the Y axis
//        let actualY = 100.0//random(min: monster.size.height/2, max: size.height - monster.size.height/2)
//
//        // Position the monster slightly off-screen along the right edge,
//        // and along a random position along the Y axis as calculated above
//        monster.position = CGPoint(x: size.width + monster.size.width/2, y: actualY)
//
//        // Add the monster to the scene
//        node.addChild(monster)
//
//        // Determine speed of the monster
//        let actualDuration = 100.0//random(min: CGFloat(2.0), max: CGFloat(4.0))
//
//        // Create the actions
//        let actionMove = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: actualY),
//                                       duration: TimeInterval(actualDuration))
//        let actionMoveDone = SKAction.removeFromParent()
//        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
//    }


//        let movePlayerAction = SKAction.moveTo(y: 100, duration: 2)
//        shape.run(movePlayerAction)

//        let field = SKFieldNode.radialGravityField()
//        addChild(field)
//
//
//        DLog(size)
//        let point = CGPoint(x: size.width / 2, y: 0)
//        DLog(point)
//        player.position = point
//        field.addChild(player)
//
//        addMonster(node: field)
//        field.addChild()
//
//        run(SKAction.repeatForever(
//            SKAction.sequence([
//                SKAction.run(addMonster(node: field)),
//                SKAction.wait(forDuration: 1.0)
//            ])
//        ))
