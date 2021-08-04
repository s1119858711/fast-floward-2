import Artist from "./contract.cdc"

pub fun main(address:Address):[String]?{
    let account = getAccount(address)
    let collectionRef = account
                            .getCapability(/public/ArtistPictureCollection)
                            .borrow<&Artist.Collection>()
                            ?? panic("couldn't borrow Collection")

    if collectionRef == nil{
        return nil
    }
    else{
        var buffer: [String] = []
        for canvas in collectionRef.getCanvases(){
            buffer.append(canvas.pixels)
        }
        return buffer
    }

}