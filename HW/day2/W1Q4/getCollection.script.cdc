import Artist from 0x01

pub fun main(){
    let accounts = [
        getAccount(0x01),
        getAccount(0x02),
        getAccount(0x03),
        getAccount(0x04),
        getAccount(0x05)
    ]

    for account in accounts{
        let collectionRef = account
                            .getCapability(/public/ArtistPictureCollection)
                            .borrow<&Artist.Collection>()
        if collectionRef == nil{
            log("Account".concat(account.address.toString()).concat(" don't have Picture Collections"))
        }
        else{
            var currentAccount = account.address.toString()
            //for 
            log("Current Account".concat(currentAccount))
            for canvas in collectionRef!.getCanvases(){
              var pictureNumber = 0
              log("Current Picture Number".concat(pictureNumber.toString()))
              var i = 0
              while i < Int(canvas.height){
                  let row = canvas.pixels.slice(from:i*Int(canvas.width), upTo: (i+1)*Int(canvas.width) )
                  log(row)
                  i = i+1
              }
              pictureNumber = pictureNumber+1
            }
            //log(collectionRef!.getAllCanvases())
        }
    }
}
