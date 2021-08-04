import Artist from "./contract.cdc"

transaction(width: UInt8, height:UInt8, pixels:String){
    let picture: @Artist.Picture?
    let collectionRef : &Artist.Collection

    prepare(account:AuthAccount){
        let printRef = getAccount(0xf8d6e0586b0a20c7)
                        .getCapability(/public/ArtistPicturePrinter)
                        .borrow<&Artist.Printer>()
                        ?? panic("Couldn't Borrow Printer")

        let canvas = Artist.Canvas(
            width:width,
            height:height,
            pixels:pixels
        )

        self.collectionRef = account
                            .getCapability(/public/ArtistPictureCollection)
                            .borrow<&Artist.Collection>()
                            ?? panic("Couldn't Borrow Collection")
        
        self.picture <- printRef.print(canvas: canvas)

        //collectionRef.deposit(picture: <- picture!)
    }
    execute{
        if self.picture != nil{
            self.collectionRef.deposit(picture: <- self.picture!)
        }
        else{
            destroy self.picture
        }
    }
}