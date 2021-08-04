import Artist from 0x03

transaction {
    let picture: @Artist.Picture?
    let collectionRef : &Artist.Collection

    prepare(account : AuthAccount){
        let printerRef = getAccount(0x03)
                        .getCapability(/public/ArtistPicturePrinter)
                        .borrow<&Artist.Printer>()
                        ?? panic("Couldn't borrow reference to Printer")

        self.collectionRef = account
                            .getCapability(/public/ArtistPictureCollection)
                            .borrow<&Artist.Collection>()
                            ?? panic("Couldn't borrow reference to Collection")

        let canvas = Artist.Canvas(
            width:5,
            height:5,
            pixels: "*   * * *   *   * * *   *"
        )

        self.picture <- printerRef.print(canvas: canvas)
        //self.collections

    }

    execute{
        if self.picture != nil{
            self.collectionRef.deposit(picture: <- self.picture!)
        }
        else{
            log("Couldn't save picture to collections")
            destroy self.picture
        }

    }
}