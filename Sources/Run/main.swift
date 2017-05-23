import App

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

/* 
 The environment affects Config and Logging. The environment is development by default. To change it, pass the --env= flag as an argument. 
*/

print("You are currently running on", config.environment.description.uppercased())

let drop = try Droplet(config)
try drop.setup()

try drop.run()

