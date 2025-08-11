import SpriteKit

class GameScene: SKScene {
    
    // MARK: - Propriedades
    fileprivate var label : SKLabelNode?
    fileprivate var spinnyNode : SKShapeNode?

    
    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
          //  print("Failed to load GameScene.sks")
         abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    func setUpScene() {
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 4.0
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 0, y: 0) //== // (x: size.width/100, y: size.height/100)
        background.blendMode = .replace
        background.zPosition = -1
        background.size = self.size
        
        addChild(background)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        makeBouncer(at: CGPoint(x: -512, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 0, y: -390))
        makeBouncer(at: CGPoint(x: 256, y: -390))
        makeBouncer(at: CGPoint(x: 512, y: -390))
        makeBouncer(at: CGPoint(x: -256, y: -390))
        makeBouncer(at: CGPoint(x: -512, y: -390))
        
        makeSlot(at: CGPoint(x: 128, y: -380), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: -380), isGood: false)
        makeSlot(at: CGPoint(x: -128, y: -380), isGood: false)
        makeSlot(at: CGPoint(x: -384, y: -380), isGood: true)
        
        self.setUpScene()
    }

    func makeSpinny(at pos: CGPoint, color: SKColor) {
        if let spinny = self.spinnyNode?.copy() as! SKShapeNode? {
            spinny.position = pos
            spinny.strokeColor = color
            self.addChild(spinny)
        }
    }
    
    func makeBouncer(at position: CGPoint) {
        
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false
        
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        switch touches.count {
        case 1:
            addBall(at: location)
            addCone(at: location)
        case 2:
            addTriangle(at: location)
            addBox(at: location)
        default:
            break
        
        }
        
        func addCone(at location: CGPoint) {
            let size: CGFloat = 64
            let path = CGMutablePath()
            let points = 4
            let angleIncrement = .pi / CGFloat(points)
            let radius = size / 2
            let innerRadius = radius * 0.5
            var angle: CGFloat = -.pi / 2
            var firstPoint = true
            
            for _ in 0..<points * 2 {
                let r = (firstPoint ? radius : innerRadius)
                let x = r * cos(angle)
                let y = r * sin(angle)
                
                if firstPoint {
                    path.move(to: CGPoint(x: x, y: y))
                    firstPoint = false
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }
                
                angle += angleIncrement
            }
            
            path.closeSubpath()
            
            let cone = SKShapeNode(path: path)
            cone.fillColor = .orange
            cone.strokeColor = .clear
            cone.position = location
            
            cone.physicsBody = SKPhysicsBody(polygonFrom: path)
            cone.physicsBody?.restitution = 1.0
            cone.physicsBody?.friction = 0.2
            cone.physicsBody?.linearDamping = 0.1
            
            addChild(cone)
        }
        
        func addTriangle(at location: CGPoint) {
            
            let trianglePath = CGMutablePath()
            let size: CGFloat = 64
            let halfSize = size / 2
            
            // Define os três pontos do triângulo
            trianglePath.move(to: CGPoint(x: 0, y: halfSize)) //topo
            trianglePath.addLine(to: CGPoint(x: -halfSize, y: -halfSize)) // canto inferior esquerdo
            trianglePath.addLine(to: CGPoint(x: halfSize, y: -halfSize)) // canto inferior direito
            trianglePath.closeSubpath()
            
            let triangle = SKShapeNode(path: trianglePath)
            triangle.fillColor = .green
            triangle.strokeColor = .clear
            triangle.physicsBody?.restitution = 1.0
            triangle.position = location // onde você quiser colocar
            
            // Física
            triangle.physicsBody = SKPhysicsBody(polygonFrom: trianglePath)
            
            addChild(triangle)
        }

        func addBall(at location: CGPoint) {
            
            let ballNames = ["ballYellow", "ballBlue", "ballYellow", "ballCyan", "ballYellow", "ballGreen", "ballYellow", "ballGrey", "ballYellow", "ballPurple", "ballYellow", "ballRed"]
            
            let randomName = ballNames.randomElement() ?? "ballYellow"
            
            let ball = SKSpriteNode(imageNamed: randomName)
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
            ball.physicsBody?.restitution = 1.0
            ball.physicsBody?.friction = 0.2
            ball.physicsBody?.linearDamping = 0.1
            ball.position = location
            
            addChild(ball)
        }
        
        func addBox(at location: CGPoint) {
            let box = SKSpriteNode(color: .yellow, size: CGSize(width: 64, height: 64))
            box.physicsBody?.restitution = 1.0
            box.position = location
            box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
            
            addChild(box)
        }
        
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches {
            self.makeSpinny(at: t.location(in: self), color: SKColor.yellow)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.makeSpinny(at: t.location(in: self), color: SKColor.yellow)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.makeSpinny(at: t.location(in: self), color: SKColor.red)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.makeSpinny(at: t.location(in: self), color: SKColor.yellow)
        }
    }
    
   
}
#endif

#if os(OSX)
// Mouse-based event handling
extension GameScene {

    override func mouseDown(with event: NSEvent) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        self.makeSpinny(at: event.location(in: self), color: SKColor.yellow)
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.makeSpinny(at: event.location(in: self), color: SKColor.blue)
    }
    
    override func mouseUp(with event: NSEvent) {
        self.makeSpinny(at: event.location(in: self), color: SKColor.red)
    }

}
#endif

