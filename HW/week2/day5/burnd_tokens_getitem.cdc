import FungibleToken from Flow.FungibleToken
import Kibble from Project.Kibble
import KittyItems from Project.KittyItems
import NonFungibleToken from Flow.NonFungibleToken
//Note
transaction(recipient:Address, amount:UFix64, typeID:UInt64){
    let tokenBurner: &Kibble.Vault
    let NFTMinter: &KittyItems.NFTMinter
    let receiverRef : &{NonFungibleToken.CollectionPublic}

    prepare(signer: AuthAccount){
        self.tokenBurner = signer.borrow<&Kibble.Vault>(from: Kibble.VaultStoragePath)
                                  ?? panic("Could not borrow Kibble Vault From VaultStoragePath")

        self.NFTMinter = signer.borrow<&KittyItems.NFTMinter>(from: KittyItems.MinterStoragePath)
                                ?? panic("Could not borrow NFT minter") 

        self.receiverRef = getAccount(recipient).getCapability(KittyItems.CollectionPublicPath)
                                                .borrow<&{NonFungibleToken.CollectionPublic}>()
                                                ?? panic("could not borrow kittyItems Collection")
                                            
    }

    execute{
        let burnRef <- self.tokenBurner.withdraw(amount: amount)
        destroy burnRef

        self.NFTMinter.mintNFT(recipient: self.receiverRef, typeID:typeID)
    }
}