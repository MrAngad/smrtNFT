# After Deploying
1. Check paused == true

# Before mint
1. Write to setMintPrice(PRICE)
2. Check mintPrice == PRICE
3. Check token address is correct

# Initiate Mint
1. Write to unpause
2. Check paused == false