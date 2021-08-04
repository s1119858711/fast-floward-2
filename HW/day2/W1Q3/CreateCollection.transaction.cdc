import Artist from 0x03

transaction {
    prepare(account : AuthAccount){
        let collection <- Artist.CreateCollection()
        account.save(<- collection,to:/storage/ArtistPictureCollection)

        account.link<&Artist.Collection>(
            /public/ArtistPictureCollection, 
            target: /storage/ArtistPictureCollection
        )
    }
}