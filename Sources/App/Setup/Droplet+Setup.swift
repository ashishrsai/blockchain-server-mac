@_exported import Vapor

extension Droplet {
    public func setup() throws {
       setUpController()
    }
    func setUpController(){
         _ = bcController(drop :self)
    }
}
