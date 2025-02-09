-- ID's of redrouter blocks, if the name of the redrouter block is 'redrouter_5', the id will be 5
engineControllerId = 0 -- The block controlling the steam engine
generatorControllerId = 0 -- The block controlling the power generators
fuelFactoryControllerId = 0 -- The block controlling the fuel factory

-- ID's of target blocks, if the name of the redrouter block is 'create_target_5', the id will be 5
engineStressometerId = 0

---------- End of config, don't edit beyond this line. ----------

return { engineControllerId = engineControllerId, generatorControllerId = generatorControllerId, fuelFactoryControllerId = fuelFactoryControllerId, engineStressometerId = engineStressometerId }