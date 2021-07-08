function sysCall_init()
    revoluteJoint = sim.getObjectHandle('RevoluteJoint')
    prismaticVerticalJoint = sim.getObjectHandle('PrismaticVerticalJoint')
    prismaticHorizontalJoint = sim.getObjectHandle('PrismaticHorizontalJoint')
    rotationStop0 = sim.getObjectHandle('RotationStop0')
    rotationStop1 = sim.getObjectHandle('RotationStop1')
    verticalStop0 = sim.getObjectHandle('VerticalStop0')
    verticalStop1 = sim.getObjectHandle('VerticalStop1')
    horizontalStop0 = sim.getObjectHandle('HorizontalStop0')
    horizontalStop1 = sim.getObjectHandle('HorizontalStop1')
    verticalTriggerTopStop = sim.getObjectHandle('ExtraStuff13')
    verticalTriggerBottomStop = sim.getObjectHandle('ConnectionToVerticalSupport1')
    rotationTriggerStop = sim.getObjectHandle('ExtraStuffForRotation')
    horizontalTriggerBackStop = sim.getObjectHandle('ExtraStuffBackStop')
    horizontalTriggerFrontStop = sim.getObjectHandle('ExtraStuffFrontStop')
end

function sysCall_actuation()
    if(r0 == 1 or r1 == 1) then
        stopRotationPosition = sim.getJointPosition(revoluteJoint)
        sim.setJointTargetPosition(revoluteJoint, stopRotationPosition)
    else
        sim.setJointTargetPosition(revoluteJoint, 305*math.pi/180)
    end
    if(v0 == 1 or v1 == 1) then
        stopVerticalPosition = sim.getJointPosition(prismaticVerticalJoint)
        sim.setJointTargetPosition(prismaticVerticalJoint, stopVerticalPosition)
    else 
        sim.setJointTargetPosition(prismaticVerticalJoint, -0.6)
    end
    if(h0 == 1 or h1 == 1) then
        stopHorizontalPosition = sim.getJointPosition(prismaticHorizontalJoint)
        sim.setJointTargetPosition(prismaticHorizontalJoint, stopHorizontalPosition)
    else 
        sim.setJointTargetPosition(prismaticHorizontalJoint, 0.02)
    end
end

function sysCall_sensing()
    r0 =sim.checkProximitySensor(rotationStop0, rotationTriggerStop)
    r1 =sim.checkProximitySensor(rotationStop1, rotationTriggerStop)
    v0 =sim.checkProximitySensor(verticalStop0, verticalTriggerBottomStop)
    v1 =sim.checkProximitySensor(verticalStop1, verticalTriggerTopStop)
    h0 =sim.checkProximitySensor(horizontalStop0, horizontalTriggerBackStop)
    h1 =sim.checkProximitySensor(horizontalStop1, horizontalTriggerFrontStop)
        
    local collisionObjectHandle = sim.getCollisionHandle('BaseCollision')
    local result, pairHandles = sim.handleCollision(collisionObjectHandle)
    if result>0 then
        print('Robot is colliding. Colliding pair is '..getAsString(pairHandles))
    end
    
end

function sysCall_cleanup()
end