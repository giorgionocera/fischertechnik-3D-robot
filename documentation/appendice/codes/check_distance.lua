function sysCall_init()
    revoluteJoint = sim.getObjectHandle('RevoluteJoint')
    prismaticVerticalJoint = sim.getObjectHandle('PrismaticVerticalJoint')
    prismaticHorizontalJoint = sim.getObjectHandle('PrismaticHorizontalJoint')
    collisionOccurred = false
    actualDistance = 100
    justDone = 0
end

function sysCall_actuation()
end

function sysCall_sensing()
    local collisionObjectHandle = sim.getCollisionHandle('BaseCollision')
    local resultCollision, pairHandles = sim.handleCollision(collisionObjectHandle)
    if resultCollision>0 then
        collisionOccurred = true
    end
    
    local tip = sim.getObjectHandle('Tip')
    local target = sim.getObjectHandle('Target')
    
    local resultDistance,distData,objectPair=sim.checkDistance(tip,target,0)
    if resultDistance>0 and actualDistance ~= distData[7] then
        actualDistance = distData[7]
        justDone = 0
    elseif actualDistance == distData[7] and justDone < 10 then
        justDone = justDone + 1
    elseif justDone == 10 then
        if(collisionOccurred) then
            print('A collision occurred')
            collisionOccurred = false
        end
        if(distData[7] < 0.0016) then
            print('Position reached: ')
        else
            print('Position cannot be reached: ')
        end
        print('\tRevolute Joint: '.. sim.getJointPosition(revoluteJoint)/math.pi*180)
        print('\tPrismatic Vertical Joint: '.. sim.getJointPosition(prismaticVerticalJoint))
        print('\tPrismatic Horizontal Joint: '.. sim.getJointPosition(prismaticHorizontalJoint))
        print('\n\n')
        justDone = justDone + 1
    end
end

function sysCall_cleanup()
end
