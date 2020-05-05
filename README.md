# Unity IOS Can Open URL

### Install
Copy/paste into your unity ```Assets``` folder

### What I can do? 

You can check **is some application installed** on iOS. Keep in mind that you need to know checking app URL sheme. 
More information about this [here](https://developer.apple.com/documentation/uikit/uiapplication/1622952-canopenurl?language=objc)

### Example

In this example I checking is *instagram* installed. If yes, will open application link, if no, will open it in browser. 

``` c#

private void OpenInstagramApp()
{
    var link = "https://www.instagram.com/nrjwolf.games/";
    // check to open in app IOS ONLY
    var iosAppLink = "instagram://user?username=nrjwolf.games";
    if (IOSCanOpenURL.CheckUrl(iosAppLink))
    {
        link = iosAppLink;
    }
    Application.OpenURL(link);
}

```

Also, you need to add *instagram* in your ```LSApplicationQueriesSchemes```. You can do it manualy, or by code using [IPostprocessBuildWithReport](https://docs.unity3d.com/ScriptReference/Build.IPostprocessBuildWithReport.OnPostprocessBuild.html), lioke this : 

``` c# 
using System.IO;
using UnityEngine;

using UnityEditor;
using UnityEditor.Build.Reporting;
using UnityEditor.Build;

#if UNITY_IOS
using UnityEditor.iOS.Xcode;
#endif

public class BuildCommand : IPostprocessBuildWithReport
{
    public int callbackOrder
    {
        get { return 2; }
    }

    public void OnPostprocessBuild(BuildReport report)
    {
        Debug.Log("OnPostprocessBuild for " + report.summary.platform);
        switch (report.summary.platform)
        {
            case BuildTarget.iOS:
                {
#if UNITY_IOS
                    const string projectName = "Unity-iPhone";
                    var pbxProjPath = Path.Combine(Path.Combine(report.summary.outputPath, projectName + ".xcodeproj"), "project.pbxproj");
                    Debug.Log("xcode project path: " + pbxProjPath);

                    var pbxProject = new PBXProject();
                    pbxProject.ReadFromFile(pbxProjPath);
                    var mainTargetGuid = pbxProject.TargetGuidByName("Unity-iPhone");

                    var plistPath = Path.Combine(report.summary.outputPath, "Info.plist");
                    var plist = new PlistDocument();
                    plist.ReadFromFile(plistPath);

                    // Add UIApplication url
                    var LSApplicationQueriesSchemesArray = plist.root.CreateArray("LSApplicationQueriesSchemes");
                    LSApplicationQueriesSchemesArray.AddString("instagram");

                    plist.WriteToFile(plistPath);
#else
                    Debug.Log("Can't build Unity iOS without UNITY_IOS define!");
#endif
                    break;
                }

            default:
                Debug.Log("no post-processing logic for platform " + report.summary.platform);
                break;
        }
    }
}
```


>I'm on [reddit](https://www.reddit.com/r/Nrjwolf/)  
>[Discord server](https://discord.gg/jwPVsat)
