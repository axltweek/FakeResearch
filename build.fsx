// include Fake lib
#r @"packages/FAKE/tools/FakeLib.dll"
open Fake

// Properties
let buildDir = "./build/"

// Targets
Target "Clean" (fun _ ->
    CleanDir buildDir
)

Target "BuildApp" (fun _ ->
    !! "HelloWorldWebApp.sln"
        |> MSBuildRelease buildDir "Build"
        // |> MSBuild buildDir "Build"
        //    [
        //         ("Configuration", "Release")
        //         ("Platform", "AnyCPU")
        //         ("DeployOnBuild", "True")
        //         ("DeployTarget", "Package")
        //         //("OutFolder", "output")
        //    ]
        |> Log "AppBuild-Output: "
)

Target "Default" (fun _ ->
    trace "Hello World from FAKE"
)

// Dependencies
"Clean"
    ==> "BuildApp"
    ==> "Default"

// start build
RunTargetOrDefault "Default"