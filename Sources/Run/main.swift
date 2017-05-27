import App
import Vapor
import LeafProvider
import PostgreSQLDriver
import AuthProvider

/// We have isolated all of our App's logic into
/// the App module because it makes our app
/// more testable.
///
/// In general, the executable portion of our App
/// shouldn't include much more code than is presented
/// here.
///
/// We simply initialize our Droplet, optionally
/// passing in values if necessary
/// Then, we pass it to our App's setup function
/// this should setup all the routes and special
/// features of our app
///
/// .run() runs the Droplet's commands, 
/// if no command is given, it will default to "serve"

/*
 The Droplet is a service container that gives you access to many of Vapor's facilities. 
 It is responsible for registering routes, starting the server, appending middleware, and more. */


let config = try Config()

try config.setup()
config.addConfigurable(log: AllCapsLogger.init, name: "all-caps")

let drop = try Droplet(config)
try drop.setupRoutes()


// Add custom Route for dataBases

drop.get("database") { request in
    if let db = drop.database?.driver as? PostgreSQLDriver.Driver {
        let version = try db.raw("SELECT version()")
        return JSON(node: version)
    } else {
        return "No db connection established, please ask your administrator"
    }
}

/*
 The environment affects Config and Logging. The environment is development by default. To change it, pass the --env= flag as an argument.
 */
let message = "You are currently running on" + drop.config.environment.description.uppercased()
print(message)

try drop.run()

