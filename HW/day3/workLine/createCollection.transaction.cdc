import Artist from "./contract.cdc"

transaction(){
    prepare(account: AuthAccount){
        account.save(
            <- Artist.CreateCollection(),
            to: /storage/ArtistPictureCollection
        )

        account.link<&Artist.Collection>(
            /public/ArtistPictureCollection,
            target: /storage/ArtistPictureCollection
        )
    }
}
