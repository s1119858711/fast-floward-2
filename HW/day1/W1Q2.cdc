//def Canvas
pub struct Canvas{
    pub let width: UInt8
    pub let height: UInt8
    pub let pixels: String

    init(width: UInt8, height: UInt8, pixels: String){
        self.width = width
        self.height = height
        self.pixels = pixels
    }
}

//def Picture
pub resource Picture {
  pub let canvas: Canvas
  
  init(canvas: Canvas) {
    self.canvas = canvas
  }
}

//def fun to serialize Array
pub fun serializeStringArray(_ lines: [String]):String{
    var buffer = ""
    for line in lines{
        buffer = buffer.concat(line)
    }

    return buffer
}

//w1q1 start 
//def display. A function that displays a canvas in a frame
//No Return
pub fun display(_ canvas: Canvas){
  let width = Int(canvas.width)
  let height = Int(canvas.height)
  let pixels = canvas.pixels

  //first def the first Line And The Last Line
  var i=0
  var HeadAndFootBuffer = ""
  while i<width+2{
    if i==0{
      HeadAndFootBuffer=HeadAndFootBuffer.concat("+")
    }
    else if i!= width+1{
      HeadAndFootBuffer=HeadAndFootBuffer.concat("-")
    }
    else {
      HeadAndFootBuffer=HeadAndFootBuffer.concat("+")
    }
    i = i+1
  }
  //log(HeadAndFootBuffer)
  //Well. First is Done, Menas We had Head And Foot Line.

  //Second Let's Def The Body and show them.
  var j=0
  var start = 0
  var end = 5
  while j<height+2{
    if j==0{
      log(HeadAndFootBuffer)
    }
    else if j!= height+1{
      var line = pixels.slice(from:start+width*(j-1) ,upTo:end+width*(j-1))
      line = "|".concat(line)
      line = line.concat("|")
      log(line)
    }
    else{
      log(HeadAndFootBuffer)
    }
    j = j+1
  }
  //Well. It's Done
}

//W1Q1 End
//W1Q2 Start.
// Create a resource than prints Picture's but only once for each unique 5*5 Canvas
pub resource Printer{
    pub let content: {String:Canvas}

    pub fun print(canvas: Canvas):@Picture? {
        if(self.content.containsKey(canvas.pixels)){
            log("Hi It is already exist")
            return nil
        }
        else{
            let picture <- create Picture(canvas: canvas)
            self.content[canvas.pixels] = canvas
            //display(self.content[canvas.pixels])
            display(canvas)
            return <- picture
        }
    }

    init(){
        self.content = {}
    }
}


pub fun main(){
    let pixelsX = [
        "*   *",
        " * * ",
        "  *  ",
        " * * ",
        "*   *"  
    ]

    let canvasX = Canvas(width:5, height:5, pixels: serializeStringArray(pixelsX))
    let printer <- create Printer()
    let picture1 <- printer.print(canvas: canvasX)
    //
    let picture2 <- printer.print(canvas: canvasX)

    destroy picture2
    destroy picture1
    destroy printer
}
